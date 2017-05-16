//
//  UIImage+CircularImage.h
//  Funny
//
//  Created by Mr.Gu on 2017/4/25.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CircularImage)

/**
 画圆角图片

 @param size 图片大小
 @param corner 圆角大小
 @param color 背景图片
 @param completion 完成回调
 */
- (void)gg_asyncDrawImageWithSize:(CGSize)size
                     cornerRadius:(BOOL)corner
                  backgroundColor:(UIColor *)color
                       completion:(void(^)(UIImage *image))completion;

@end
