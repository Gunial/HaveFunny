//
//  GGCommentModel.h
//  Funny
//
//  Created by Mr.Gu on 2017/5/8.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GGUserModel;

@interface GGCommentModel : NSObject

/** 评论 id */
@property (nonatomic, copy) NSString *ID;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户模型 */
@property (nonatomic, strong) GGUserModel *user;

/** 记录按钮是否被点击 */
@property (nonatomic, assign) BOOL isSelected;

@end
