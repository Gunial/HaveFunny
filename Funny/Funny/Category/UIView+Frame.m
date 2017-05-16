//
//  UIView+Frame.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/19.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setGg_x:(CGFloat)gg_x
{
    CGRect frame = self.frame;
    frame.origin.x = gg_x;
    self.frame = frame;
}

- (CGFloat)gg_x
{
    return self.frame.origin.x;
}

- (void)setGg_y:(CGFloat)gg_y
{
    CGRect frame = self.frame;
    frame.origin.y = gg_y;
    self.frame = frame;
}

- (CGFloat)gg_y
{
    return self.frame.origin.y;
}

- (void)setGg_width:(CGFloat)gg_width
{
    CGRect frame = self.frame;
    frame.size.width = gg_width;
    self.frame = frame;
}

- (CGFloat)gg_width
{
    return self.frame.size.width;
}

- (void)setGg_height:(CGFloat)gg_height
{
    CGRect frame = self.frame;
    frame.size.height = gg_height;
    self.frame = frame;
}

- (CGFloat)gg_height
{
    return self.frame.size.height;
}

- (void)setGg_centerX:(CGFloat)gg_centerX
{
    CGPoint center = self.center;
    center.x = gg_centerX;
    self.center = center;
}

- (CGFloat)gg_centerX
{
    return self.center.x;
}

- (void)setGg_centerY:(CGFloat)gg_centerY
{
    CGPoint center = self.center;
    center.y = gg_centerY;
    self.center = center;
}

- (CGFloat)gg_centerY
{
    return self.center.y;
}

- (void)setGg_size:(CGSize)gg_size
{
    CGRect frame = self.frame;
    frame.size = gg_size;
    self.frame = frame;
}

- (CGSize)gg_size
{
    return self.frame.size;
}
@end
