//
//  GGpictureView.h
//  Funny
//
//  Created by Mr.Gu on 2017/4/26.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GGTopicModel;

@interface GGpictureView : UIView

/** 话题模型 */
@property (nonatomic, strong)  GGTopicModel *topicModel;

+ (instancetype)picture;

@end
