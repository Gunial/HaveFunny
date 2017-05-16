//
//  GGNewTopicViewController.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/19.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGNewTopicViewController.h"

@interface GGNewTopicViewController ()

@end

@implementation GGNewTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar];
}

- (void)setUpNavigationBar
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon" highlightImageName:@"MainTagSubIconClick" target:self action:nil];

}

@end
