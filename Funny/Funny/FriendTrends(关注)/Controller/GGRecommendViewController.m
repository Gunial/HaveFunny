//
//  GGRecommendViewController.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/20.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGRecommendViewController.h"

#import "GGRecommendCategoryCell.h"
#import "GGRecommendUserCell.h"

#import "GGRecommendCategory.h"
#import "GGRecommendUser.h"

#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>

#define GGSelectedCategory self.categoryDataSource[self.categoryTableView.indexPathForSelectedRow.row]

@interface GGRecommendViewController ()<UITableViewDataSource, UITableViewDelegate>

/** 左侧推荐数据源 */
@property (nonatomic, strong) NSArray *categoryDataSource;
/** 左侧推荐表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

/** 左侧推荐用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/** 上一次网络请求的参数 */
@property (nonatomic, strong) NSMutableDictionary *lastParams;

@end

static NSString *const RecommendCategoryId = @"GGRecommendCategoryCell";
static NSString *const RecommendUserId = @"GGRecommendUserCell";

@implementation GGRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐关注";
    self.view.backgroundColor = APP_DEFAULT_BACKGROUNDCOLOR;
    
    [self setupTableView];
    [self setupRefreshControl];
    
    [self loadRecommenndCategoryData];
}

/** 请求左侧分类的网络数据 */
- (void)loadRecommenndCategoryData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [SVProgressHUD showWithStatus:@"拼命加载中..."];
    
    [[GGNetworkManager shareManager] httpRequest:GET urlString:BaseURL parameters:params success:^(id response) {
        self.categoryDataSource = [GGRecommendCategory mj_objectArrayWithKeyValuesArray:response[@"list"]];
        [SVProgressHUD dismiss];
        [self.categoryTableView reloadData];

        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"推荐关注加载失败"];
    }];
}

/** 设置表格 */
- (void)setupTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.rowHeight = 60;
    
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([GGRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:RecommendCategoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([GGRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:RecommendUserId];
}

/** 添加刷新控件 */
- (void)setupRefreshControl
{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden = YES;
}

#pragma mark - 加载推荐用户数据
- (void)loadNewUsers
{
    GGRecommendCategory *category = GGSelectedCategory;
    category.currentPage = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.categoryId);
    self.lastParams = params;
    [[GGNetworkManager shareManager] httpRequest:GET urlString:BaseURL parameters:params success:^(id response) {
        
        if (self.lastParams != params) return;
        
        NSArray *userModel = [GGRecommendUser mj_objectArrayWithKeyValuesArray:response[@"list"]];
        [category.users removeAllObjects];
        [category.users addObjectsFromArray:userModel];
        category.total = [response[@"total"] integerValue];
        category.total_page = [response[@"total_page"] integerValue];
        
        [self.userTableView reloadData];
        
        [self.userTableView.mj_header endRefreshing];
        
        [self controlFooterState];
        
    } failure:^(NSError *error) {
        if (self.lastParams != params) return;

        [self.userTableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
    }];
}

- (void)loadMoreUsers
{
    GGRecommendCategory *category = GGSelectedCategory;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.categoryId);
    params[@"page"] = @(++category.currentPage);
    self.lastParams = params;

    [[GGNetworkManager shareManager] httpRequest:GET urlString:BaseURL parameters:params success:^(id response) {
        
        if (self.lastParams != params) return;
        
        NSArray *userModel = [GGRecommendUser mj_objectArrayWithKeyValuesArray:response[@"list"]];
        [category.users addObjectsFromArray:userModel];
        [self.userTableView reloadData];
        
        [self controlFooterState];
        
    } failure:^(NSError *error) {
        if (self.lastParams != params) return;

        [self.userTableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
    }];
}

/**
 * 控制 footer 的状态
 */
- (void)controlFooterState
{
    GGRecommendCategory *category = GGSelectedCategory;
    
    self.userTableView.mj_footer.hidden = (category.users.count == 0);

    if (category.users.count == category.total) { // 没有更多的数据了
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else{ //还有更多的数据
        [self.userTableView.mj_footer endRefreshing];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag) {// 推荐用户
        
        [self controlFooterState];
        
        return [GGSelectedCategory users].count;
    }else {
        return self.categoryDataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag) {// 推荐用户
        GGRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendUserId forIndexPath:indexPath];

        cell.userModel = [GGSelectedCategory users][indexPath.row];
        
        return cell;
    }else {
        GGRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendCategoryId forIndexPath:indexPath];
        
        cell.category = self.categoryDataSource[indexPath.row];
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!tableView.tag) {
        GGRecommendCategory *category = self.categoryDataSource[indexPath.row];
        if (category.users.count) {
            [self.userTableView reloadData];
        }else {
            [self.userTableView reloadData];
            
            [self.userTableView.mj_header beginRefreshing];
        }
    }
}

- (void)dealloc
{
    /** 取消所有网络请求,防止请求回调,控制器销毁,程序奔溃*/
    [[GGNetworkManager shareManager].operationQueue cancelAllOperations];
}

@end
