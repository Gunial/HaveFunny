//
//  GGVerticalButton.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/24.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGVerticalButton.h"

@implementation GGVerticalButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupTextAlignment];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupTextAlignment];
    }
    return self;
}

- (void)setupTextAlignment
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 修改 imageView 的位置
    self.imageView.gg_x = 0;
    self.imageView.gg_y = 0;
    self.imageView.gg_width = self.gg_width;
    self.imageView.gg_height = self.imageView.gg_width;
    
    // 修改 titleLabel 的位置
    self.titleLabel.gg_x = 0;
    self.titleLabel.gg_y = self.imageView.gg_height;
    self.titleLabel.gg_width = self.gg_width;
    self.titleLabel.gg_height = self.gg_height - self.titleLabel.gg_y;
}

@end
