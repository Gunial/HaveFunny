//
//  GGTopicModel.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/25.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGTopicModel.h"
#import "GGCommentModel.h"
#import "GGUserModel.h"
#import <MJExtension.h>

@implementation GGTopicModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"top_cmt" : @"GGCommentModel"};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"topicId" : @"id"};
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        
        /** 文字高度 */
        CGSize maxSize = CGSizeMake(kScreenWidth - 2 * TopicCellMargin, MAXFLOAT);
        CGFloat textHeight = [_text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
        
        /** 图片视图的 frame */
        if (_type == GGTopicTypePicture) {
            CGFloat pictureX = TopicCellMargin;
            CGFloat pictureY = TopicCellTextY + textHeight + TopicCellMargin;
            CGFloat pictureW = kScreenWidth - 2 * TopicCellMargin;
            CGFloat pictuteH = pictureW * (_height / _width);
            
            if (pictuteH > kScreenHeight) { // 长图限制
                pictuteH = KIphoneSize_Height(300);
                _is_big = YES;
            }
            _pictureFrame = CGRectMake(pictureX, pictureY, pictureW, pictuteH);
            _cellHeight += pictuteH + TopicCellMargin;
        }
        else if (_type == GGTopicTypeVoice){
            CGFloat voiceX = TopicCellMargin;
            CGFloat voiceY = TopicCellTextY + textHeight + TopicCellMargin;
            CGFloat voiceW = kScreenWidth - 2 * TopicCellMargin;
            CGFloat voiceH = voiceW * (_height / _width);
            _voiceFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            _cellHeight += voiceH + TopicCellMargin;
        }
        else if (_type == GGTopicTypeVideo) {
            CGFloat videoX = TopicCellMargin;
            CGFloat videoY = TopicCellTextY + textHeight + TopicCellMargin;
            CGFloat videoW = kScreenWidth - 2 * TopicCellMargin;
            CGFloat videoH = videoW * (_height / _width);
            _videoFrame = CGRectMake(videoX, videoY, videoW, videoH);
            _cellHeight += videoH + TopicCellMargin;
        }
        
        if (_top_cmt.count > 0) {
            GGCommentModel *cmtModel = [_top_cmt firstObject];
            NSString *contentText = [NSString stringWithFormat:@"%@ : %@",cmtModel.user.username, cmtModel.content];
            
            CGFloat contentHeight = [contentText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
            _cellHeight += contentHeight + 2*TopicCellMargin;
        }
        
        _cellHeight += TopicCellTextY + textHeight + TopicCellMargin + TopicCellBottomBarHeight;

    }
    return _cellHeight;
}

@end

