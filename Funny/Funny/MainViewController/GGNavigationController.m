//
//  GGNavigationController.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/20.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGNavigationController.h"

@interface GGNavigationController ()

@end

@implementation GGNavigationController

+ (void)initialize
{
    [[UINavigationBar appearanceWhenContainedIn:[self class], nil] setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = nil;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count > 0) {
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithTitle:@"返回" imageName:@"navigationButtonReturn" highlightImageName:@"navigationButtonReturnClick" target: self action:@selector(backAction)];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)backAction
{
    [self popViewControllerAnimated:YES];
}

@end
