//
//  GGPushGuideView.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/24.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGPushGuideView.h"

#define GGVersionKey @"CFBundleShortVersionString"

@implementation GGPushGuideView


+ (void)showGuideView
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[GGVersionKey];
    NSString *sandBoxVersion = [[NSUserDefaults standardUserDefaults] valueForKey:GGVersionKey];
    
    if (![currentVersion isEqualToString:sandBoxVersion]) {
        GGPushGuideView *guideView = [GGPushGuideView gudieView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:GGVersionKey];
    }
}

+ (instancetype)gudieView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)dismissButtonclick
{
    [self removeFromSuperview];
}


@end
