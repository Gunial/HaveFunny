//
//  GGCommentViewController.m
//  Funny
//
//  Created by Mr.Gu on 2017/5/8.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGCommentViewController.h"

#import "GGTopicCell.h"
#import "GGCommentCell.h"

#import "GGTopicModel.h"
#import "GGCommentModel.h"

#import <MJRefresh.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

@interface GGCommentViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;

/** 数据源数组 */
@property (nonatomic, strong) NSMutableArray *dataSource;

/** 保存最热评论 */
@property (nonatomic, strong) NSArray *saved_topcmt;

/** 页数 */
@property (nonatomic, assign) NSInteger page;

@end


static NSString *CommentCellID = @"GGCommentCell";
@implementation GGCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"评论";
    [self setupnavigationItem];
    [self setupTableView];
    [self setupRefreshControl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)setupRefreshControl
{
    self.commentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.commentTableView.mj_header beginRefreshing];
    
    self.commentTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.commentTableView.mj_footer.hidden = YES;
}

- (void)loadNewComments
{
    [SVProgressHUD show];
    self.page = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topicModel.topicId;
    
    
    [[GGNetworkManager shareManager] httpRequest:GET urlString:BaseURL parameters:params success:^(id response) {

        [SVProgressHUD dismiss];
        
        // 没有数据
        if (![response isKindOfClass:[NSDictionary class]]) {
            [self.commentTableView.mj_header endRefreshing];
            self.commentTableView.mj_footer.hidden = YES;
            return;
        }
        self.page ++;
        
        self.dataSource = [GGCommentModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
        
        [self.commentTableView reloadData];
        [self.commentTableView.mj_header endRefreshing];
        
        NSInteger totalCount = [response[@"total"] integerValue];
        if (self.dataSource.count >= totalCount || self.dataSource.count % 10 != 0) {
            [self.commentTableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError *error) {
        [self.commentTableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载失败..."];
    }];
}

- (void)loadMoreComments
{
    GGCommentModel *cmtModel = [self.dataSource lastObject];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topicModel.topicId;
    params[@"page"] = @(self.page);
    params[@"lastcid"] = cmtModel.ID;
    
    [[GGNetworkManager shareManager] httpRequest:GET urlString:BaseURL parameters:params success:^(id response) {
        
        self.page ++;
        
        NSArray *newComments = [GGCommentModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
        
        [self.dataSource addObjectsFromArray:newComments];
        
        [self.commentTableView reloadData];
        
        NSInteger totalCount = [response[@"total"] integerValue];
        if (self.dataSource.count >= totalCount || self.dataSource.count % 10 != 0) {
            [self.commentTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.commentTableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        [self.commentTableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载失败..."];
    }];

}

- (void)setupTableView
{
    if (self.topicModel.top_cmt.count) {
        self.saved_topcmt = self.topicModel.top_cmt;
        self.topicModel.top_cmt = nil;
        [self.topicModel setValue:@0 forKey:@"cellHeight"];
    }
    
    GGTopicCell *cell = [GGTopicCell cell];
    cell.topicModel = self.topicModel;
    cell.gg_height = self.topicModel.cellHeight;
    self.commentTableView.tableHeaderView = cell;
    
    self.commentTableView.contentInset = UIEdgeInsetsMake(0, 0, TopicCellMargin, 0);
    self.commentTableView.estimatedRowHeight = 70;
    self.commentTableView.rowHeight = UITableViewAutomaticDimension;
    [self.commentTableView registerNib:[UINib nibWithNibName:@"GGCommentCell" bundle:nil] forCellReuseIdentifier:CommentCellID];
    self.commentTableView.tableFooterView = [UIView new];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notify
{
    CGRect keyboardFrame = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomSpace.constant = kScreenHeight - keyboardFrame.origin.y;
    
    CGFloat durationTime = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:durationTime animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)setupnavigationItem
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"comment_nav_item_share_icon" highlightImageName:@"comment_nav_item_share_icon_click" target:self action:nil];
}

- (void)dealloc
{
    if (self.saved_topcmt.count) {
        self.topicModel.top_cmt = self.saved_topcmt;
        [self.topicModel setValue:@0 forKey:@"cellHeight"];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.saved_topcmt.count > 0 ? 2 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    self.commentTableView.mj_footer.hidden = !self.dataSource.count;
    
    if (self.saved_topcmt.count > 0) {
        return section ? self.dataSource.count : 1;
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GGCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentCellID forIndexPath:indexPath];
    
    if (self.saved_topcmt.count > 0) {
        if (!indexPath.section) {
            cell.commentModel = [self.saved_topcmt firstObject];
        }else {
            cell.commentModel = self.dataSource[indexPath.row];
        }
    }else {
        cell.commentModel = self.dataSource[indexPath.row];
    }
    
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (!self.dataSource.count) return nil;
    
    if (self.saved_topcmt.count > 0) {
        return section ? @"最新评论" : @"最热评论";
    }
    return @"最新评论";
}

#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
