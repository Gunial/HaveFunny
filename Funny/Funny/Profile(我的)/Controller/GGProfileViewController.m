//
//  GGProfileViewController.m
//  Funny
//
//  Created by Mr.Gu on 2017/5/10.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGProfileViewController.h"
#import "GGProfileFooterView.h"
#import "GGSettingViewController.h"

#import "GGProfileCell.h"

@interface GGProfileViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *ProfileCellID = @"GGProfileCell";
@implementation GGProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigationBar];
    [self setupTableView];
}

- (void)setupTableView
{
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[GGProfileFooterView alloc] init];
}

- (void)setUpNavigationBar
{
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImageName:@"mine-moon-icon" highlightImageName:@"mine-moon-icon-click" target:self action:nil];
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImageName:@"mine-setting-icon" highlightImageName:@"mine-setting-icon-click" target:self action:@selector(clickSettingAction)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
}

- (void)clickSettingAction
{
    GGSettingViewController *settingVc = [[GGSettingViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:settingVc animated:YES];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GGProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:ProfileCellID forIndexPath:indexPath];
   
    cell.textLabel.text = @"登录/注册";
    cell.imageView.image = [UIImage imageNamed:@"defaultUserIcon"];

    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [_tableView registerClass:[GGProfileCell class] forCellReuseIdentifier:ProfileCellID];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

@end
