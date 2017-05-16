//
//  GGTabBarController.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/19.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGTabBarController.h"
#import "GGNavigationController.h"

#import "GGEssenceViewController.h"
#import "GGNewTopicViewController.h"
#import "GGPublishViewController.h"
#import "GGFriendTrendsViewController.h"
#import "GGProfileViewController.h"

@interface GGTabBarController ()

@property (nonatomic, strong) UIButton *publishButton;

@end

@implementation GGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = RGBACOLOR(81, 81, 81, 1.0);
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    
    [self addAllChildViewController];
    
    self.publishButton.center = CGPointMake(self.tabBar.gg_width * 0.5, self.tabBar.gg_height * 0.5);
    [self.tabBar addSubview:self.publishButton];
}

/**
 * 添加所有子控制器
 */
- (void)addAllChildViewController
{
    GGEssenceViewController *essenceVc = [[GGEssenceViewController alloc] init];
    [self setupChildViewController:essenceVc title:@"精华" imageName:@"tabBar_essence_icon" selectedImageName:@"tabBar_essence_click_icon"];
    
    GGNewTopicViewController *newTopicVc = [[GGNewTopicViewController alloc] init];
    [self setupChildViewController:newTopicVc title:@"新帖" imageName:@"tabBar_new_icon" selectedImageName:@"tabBar_new_click_icon"];
    
    UIViewController *vc = [[UIViewController alloc] init];
    /** 禁止中间控制器tabBarItem的用户交互,让点击发布按钮的事件触发 */
    vc.tabBarItem.enabled = NO;
    [self addChildViewController:vc];
    
    GGFriendTrendsViewController *friendTrendsVc = [[GGFriendTrendsViewController alloc] init];
    [self setupChildViewController:friendTrendsVc title:@"关注" imageName:@"tabBar_friendTrends_icon" selectedImageName:@"tabBar_friendTrends_click_icon"];
    
    GGProfileViewController *profileVc = [[GGProfileViewController alloc] init];
    [self setupChildViewController:profileVc title:@"我的" imageName:@"tabBar_me_icon" selectedImageName:@"tabBar_me_click_icon"];
}

/**
 * 设置子控制器
 */
- (void)setupChildViewController:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    GGNavigationController *nav = [[GGNavigationController alloc] initWithRootViewController:vc];
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    
    [self addChildViewController:nav];
}

- (void)publishButtonClick
{
    GGPublishViewController *publishVc = [[GGPublishViewController alloc] init];
    [self presentViewController:publishVc animated:NO completion:nil];
}

#pragma mark - getter
- (UIButton *)publishButton
{
    if (_publishButton == nil) {
        _publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [_publishButton sizeToFit];
        
        [_publishButton addTarget:self action:@selector(publishButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishButton;
}

@end
