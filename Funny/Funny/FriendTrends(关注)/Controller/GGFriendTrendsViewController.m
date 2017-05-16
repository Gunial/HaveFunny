//
//  GGFriendTrendsViewController.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/20.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGFriendTrendsViewController.h"
#import "GGRecommendViewController.h"
#import "GGLoginRegisterViewController.h"

@interface GGFriendTrendsViewController ()

@end

@implementation GGFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigationBar];
}

- (void)setUpNavigationBar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"friendsRecommentIcon" highlightImageName:@"friendsRecommentIcon-click" target:self action:@selector(remommendButtonClick)];
}

- (void)remommendButtonClick
{
    GGRecommendViewController *recommendVc = [[GGRecommendViewController alloc] init];
    [self.navigationController pushViewController:recommendVc animated:YES];
}

/** 登录注册 */
- (IBAction)registerOrLogin:(UIButton *)sender {
    GGLoginRegisterViewController *loginRegisterVc = [[GGLoginRegisterViewController alloc] init];
    [self presentViewController:loginRegisterVc animated:YES completion:nil];
}

@end
