//
//  GGRecommendCategory.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/20.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGRecommendCategory.h"
#import <MJExtension.h>


@implementation GGRecommendCategory

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"categoryId" : @"id"};
}

- (NSMutableArray *)users
{
    if (_users == nil) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
