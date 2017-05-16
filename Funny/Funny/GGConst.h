//
//  GGConst.h
//  Funny
//
//  Created by Mr.Gu on 2017/4/26.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GGTopicType) {
    GGTopicTypeTotal = 1,
    GGTopicTypePicture = 10,
    GGTopicTypeStory = 29,
    GGTopicTypeVoice = 31,
    GGTopicTypeVideo = 41,
};

/** 话题 cell 中的间隙 */
UIKIT_EXTERN CGFloat const TopicCellMargin;
/** 话题 cell 文本内容 Y 值 */
UIKIT_EXTERN CGFloat const TopicCellTextY;
/** 话题 cell 底部工具栏高度 */
UIKIT_EXTERN CGFloat const TopicCellBottomBarHeight;
