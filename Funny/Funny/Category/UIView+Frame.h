//
//  UIView+Frame.h
//  Funny
//
//  Created by Mr.Gu on 2017/4/19.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

/**
 x 值
 */
@property (nonatomic, assign) CGFloat gg_x;

/**
 y 值
 */
@property (nonatomic, assign) CGFloat gg_y;

/**
 宽度
 */
@property (nonatomic, assign) CGFloat gg_width;

/**
 高度
 */
@property (nonatomic, assign) CGFloat gg_height;

/**
 中心点 x 值
 */
@property (nonatomic, assign) CGFloat gg_centerX;

/**
 中心点 y 值
 */
@property (nonatomic, assign) CGFloat gg_centerY;


/** size */
@property (nonatomic, assign) CGSize gg_size;

@end
