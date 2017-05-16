//
//  GGRecommendUser.h
//  Funny
//
//  Created by Mr.Gu on 2017/4/21.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGRecommendUser : NSObject

/** 头像 */
@property (nonatomic, copy) NSString *header;

/** uid */
@property (nonatomic, assign) NSInteger uid;

/** 是否是会员 */
@property (nonatomic, assign) BOOL is_vip;

/** is_follow */
@property (nonatomic, assign) BOOL is_follow;

/** 介绍 */
@property (nonatomic, copy) NSString *introduction;

/** 粉丝数 */
@property (nonatomic, assign) NSInteger fans_count;

/** 性别  */
@property (nonatomic, assign) NSInteger gender;

/** 帖子数量 */
@property (nonatomic, assign) NSInteger tiezi_count;

/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;

@end
