//
//  UIBarButtonItem+Item.h
//  Funny
//
//  Created by Mr.Gu on 2017/4/19.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)

/**
 创建导航栏按钮

 @param imageName 默认图片
 @param highlightImageName 高亮图片
 @param target 方法对象
 @param action 方法名
 */
+ (instancetype)itemWithImageName:(NSString *)imageName
               highlightImageName:(NSString *)highlightImageName
                           target:(id)target
                           action:(SEL)action;

/**
 创建导航栏返回按钮

 @param title 按钮名称
 @param imageName 默认图片
 @param highlightImageName 高亮图片
 @param target 方法对象
 @param action 方法名
 */
+ (instancetype)backItemWithTitle:(NSString *)title
                        imageName:(NSString *)imageName
               highlightImageName:(NSString *)highlightImageName
                           target:(id)target
                           action:(SEL)action;

@end
