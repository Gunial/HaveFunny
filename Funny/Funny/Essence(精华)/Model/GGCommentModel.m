//
//  GGCommentModel.m
//  Funny
//
//  Created by Mr.Gu on 2017/5/8.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGCommentModel.h"
#import <MJExtension.h>

@implementation GGCommentModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

@end
