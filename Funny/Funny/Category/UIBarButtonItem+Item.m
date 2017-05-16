//
//  UIBarButtonItem+Item.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/19.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "UIBarButtonItem+Item.h"
 
@implementation UIBarButtonItem (Item)

+ (instancetype)itemWithImageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (instancetype)backItemWithTitle:(NSString *)title imageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    [button setTitleColor:kBlackColor forState:UIControlStateNormal];
    [button setTitleColor:kRedColor forState:UIControlStateHighlighted];
    [button sizeToFit];
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end

