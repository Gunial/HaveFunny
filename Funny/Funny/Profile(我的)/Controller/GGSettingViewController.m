//
//  GGSettingViewController.m
//  Funny
//
//  Created by Mr.Gu on 2017/5/10.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGSettingViewController.h"
#import <SDImageCache.h>

@interface GGSettingViewController ()

/** 缓存大小 */
@property (nonatomic, copy) NSString *cacheSize;

@end

@implementation GGSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self getDiskCacheSize];
}

- (void)setupTableView
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)getDiskCacheSize
{
    NSUInteger size = [[SDImageCache sharedImageCache] getSize];
    CGFloat fileSize = size / 1000.0 /1000;
    self.cacheSize = [NSString stringWithFormat:@"%.2fMB",fileSize];
    NSLog(@"%@",self.cacheSize);
    
    [self.tableView reloadData];
}

#pragma mark - <TableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [NSString stringWithFormat:@"清除缓存(已使用%@)",self.cacheSize];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    return cell;
}

#pragma mark - <TableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        [self getDiskCacheSize];
    }];
}

@end
