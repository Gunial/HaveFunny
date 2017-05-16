//
//  UILabel+Attribute.h
//  Funny
//
//  Created by Mr.Gu on 2017/5/8.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Attribute)

/**
 最热评论富文本

 @param username 用户名
 @param content 用户评论
 */
- (void)gg_userName:(NSString *)username
            content:(NSString *)content;

@end
