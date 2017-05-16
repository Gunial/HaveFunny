//
//  GGBaseTopicViewController.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/25.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGBaseTopicViewController.h"
#import "GGCommentViewController.h"
#import "GGNewTopicViewController.h"

#import "GGTopicCell.h"
#import "GGTopicModel.h"

#import <MJExtension.h>
#import <MJRefresh.h>

@interface GGBaseTopicViewController ()

/** 数据源数组 */
@property (nonatomic, strong) NSMutableArray *dataSource;

@end


static NSString *const topicCellID = @"GGTopicCell";

@implementation GGBaseTopicViewController
{
    /** 加载下一页参数 */
    NSString *_maxtime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupRefreshControl];
}

- (void)setupTableView
{
    self.tableView.backgroundColor = kClearColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    CGFloat bottom = self.tabBarController.tabBar.gg_height;
    CGFloat top = 104;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GGTopicCell class]) bundle:nil] forCellReuseIdentifier:topicCellID];
    
}


// newlist

- (NSString *)listType
{
    return [self.parentViewController isKindOfClass:[GGNewTopicViewController class]] ? @"newlist" : @"list";
}

- (void)setupRefreshControl
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopicData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopicData)];
}

- (void)loadNewTopicData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = [self listType];
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    [[GGNetworkManager shareManager] httpRequest:GET urlString:BaseURL parameters:params success:^(id response) {
    
        _maxtime = response[@"info"][@"maxtime"];
        self.dataSource = [GGTopicModel mj_objectArrayWithKeyValuesArray:response[@"list"]];
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
    }];
}

- (void)loadMoreTopicData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = [self listType];
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"maxtime"] = _maxtime;
    
    [[GGNetworkManager shareManager] httpRequest:GET urlString:BaseURL parameters:params success:^(id response) {
        
        _maxtime = response[@"info"][@"maxtime"];
        NSArray *moreData = [GGTopicModel mj_objectArrayWithKeyValuesArray:response[@"list"]];
        [self.dataSource addObjectsFromArray:moreData];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableView.mj_footer.hidden = (self.dataSource.count == 0);
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GGTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicCellID forIndexPath:indexPath];
    
    cell.topicModel = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GGTopicModel *topicModel = self.dataSource[indexPath.row];
    return  topicModel.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GGCommentViewController *commentVc = [[GGCommentViewController alloc] init];
    commentVc.topicModel = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:commentVc animated:YES];
}


@end
