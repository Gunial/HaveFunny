//
//  GGRecommendCategory.h
//  Funny
//
//  Created by Mr.Gu on 2017/4/20.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGRecommendCategory : NSObject

/** id */
@property (nonatomic, assign) NSInteger categoryId;

/** name */
@property (nonatomic, copy) NSString *name;

/** count */
@property (nonatomic, assign) NSInteger count;


/** 避免重复发送网络请求,将右边推荐用户的模型数组存储起来 */

/** 对应的右边推荐用户模型数组 */
@property (nonatomic, strong) NSMutableArray *users;

/** 记录右侧推荐用户的总页数和总数量,控制上拉刷新 */

/** 总数量 */
@property (nonatomic, assign) NSInteger total;
/** 总页数 */
@property (nonatomic, assign) NSInteger total_page;
/** 当前页数 */
@property (nonatomic, assign) NSInteger currentPage;

@end
