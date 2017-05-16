//
//  GGTopicModel.h
//  Funny
//
//  Created by Mr.Gu on 2017/4/25.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGTopicModel : NSObject

/** 帖子 id */
@property (nonatomic, copy) NSString *topicId;

/** 创建帖子的时间 */
@property (nonatomic, copy) NSString *created_at;

/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;

/** 头像 */
@property (nonatomic, copy) NSString *profile_image;

/** 段子内容 */
@property (nonatomic, copy) NSString *text;

/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;

/** 踩的数量 */
@property (nonatomic, assign) NSInteger hate;

/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;

/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;

/** image0 */
@property (nonatomic, copy) NSString *image0;
/** image1 */
@property (nonatomic, copy) NSString *image1;
/** image2 */
@property (nonatomic, copy) NSString *image2;
/** cdn_img */
@property (nonatomic, copy) NSString *cdn_img;
/** 宽度 */
@property (nonatomic, assign) CGFloat width;
/** 高度 */
@property (nonatomic, assign) CGFloat height;

/** 播放次数 */
@property (nonatomic, assign) NSInteger playfcount;
/** 音频时长 */
@property (nonatomic, copy) NSString *voicelength;
/** 音频播发地址 */
@property (nonatomic, copy) NSString *voiceuri;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;

/** 视频长度 */
@property (nonatomic, assign) NSInteger videotime;
/** 视频播放地址 */
@property (nonatomic, copy) NSString *videouri;

/** 是否是 gif 图 */
@property (nonatomic, assign) BOOL is_gif;

/** 话题类型 */
@property (nonatomic, assign) GGTopicType type;

/** 最热评论  */
@property (nonatomic, strong) NSArray *top_cmt;


/** 辅助属性 */
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** pictureView frame */
@property (nonatomic, assign) CGRect pictureFrame;
/** 是否是长图 */
@property (nonatomic, assign) BOOL is_big;

/** 上一次的下载进度 */
@property (nonatomic, assign)  CGFloat progress;

/** voiceView frame */
@property (nonatomic, assign) CGRect voiceFrame;
/** videoView frame */
@property (nonatomic, assign) CGRect videoFrame;

@end
