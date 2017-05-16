//
//  GGProgressView.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/27.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGProgressView.h"

@implementation GGProgressView

- (void)gg_setupProgress:(CGFloat)progress animated:(BOOL)animated
{
    [self setProgress:progress animated:animated];
    self.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
}

@end
