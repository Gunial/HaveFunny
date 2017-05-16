//
//  UIImageView+CircularImage.h
//  Funny
//
//  Created by Mr.Gu on 2017/4/25.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CircularImage)


/**
 设置网络圆角图片

 @param urlString 图片 url
 @param placeholderImageName  占位图片名称
 @param corner 是否圆角
 @param color 背景颜色
 */
- (void)gg_setCircularImageWithURL:(NSString *)urlString
              placeholderImageName:(NSString *)placeholderImageName
                      cornerRadius:(BOOL)corner
                   backgroundColor:(UIColor *)color;


/**
 设置圆角图片

 @param image 图片
 @param corner 是否圆角
 @param color 背景颜色
 */
- (void)gg_setCircularImage:(UIImage *)image
               cornerRadius:(BOOL)corner
            backgroundColor:(UIColor *)color;

@end
