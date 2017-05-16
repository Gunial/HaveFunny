//
//  GGTopicVoiceView.h
//  Funny
//
//  Created by Mr.Gu on 2017/4/28.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GGTopicModel;
@interface GGTopicVoiceView : UIView

/** 模型 */
@property (nonatomic, strong) GGTopicModel *topicModel;

+ (instancetype)voice;

@end
