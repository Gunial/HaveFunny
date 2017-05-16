//
//  UIImage+CircularImage.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/25.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "UIImage+CircularImage.h"

@implementation UIImage (CircularImage)

- (void)gg_asyncDrawImageWithSize:(CGSize)size cornerRadius:(BOOL)corner backgroundColor:(UIColor *)color completion:(void(^)(UIImage *image))completion
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        CGSize imageSize = CGSizeEqualToSize(self.size, size) ? self.size : size;
        CGFloat cornerRadius = corner ? MIN(imageSize.width, imageSize.height) * 0.5 : 0;
        
        UIGraphicsBeginImageContextWithOptions(imageSize, color != nil, [UIScreen mainScreen].scale);
        
        CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
        
        if (color) {
            [color setFill];
        }else{
            [[UIColor clearColor] setFill];
        }
        
        UIRectFill(rect);
        
        // 设置圆角
        
        if (corner) {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
            [path addClip];
        }
        
        // 绘制图像
        [self drawInRect:rect];
        
        UIImage *image =  UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        // 主线程更新 UI，提示：有的时候异步也能更新 UI，但是会非常慢！
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(image);
        });
    });
}


@end
