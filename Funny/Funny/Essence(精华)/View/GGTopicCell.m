//
//  GGTopicCell.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/25.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGTopicCell.h"

#import "GGpictureView.h"
#import "GGTopicVoiceView.h"
#import "GGTopicVideoView.h"

#import "GGTopicModel.h"
#import "GGCommentModel.h"
#import "GGUserModel.h"

#import "UIImageView+CircularImage.h"



@interface GGTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *hateBtn;
@property (weak, nonatomic) IBOutlet UIButton *repostBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

/** 图片视图 */
@property (nonatomic, strong) GGpictureView *pictureView;
/** 声音视图 */
@property (nonatomic, strong) GGTopicVoiceView *voiceView;
/** 视频视图 */
@property (nonatomic, strong) GGTopicVideoView *videoView;

@property (weak, nonatomic) IBOutlet UIView *cmtView;

@property (weak, nonatomic) IBOutlet UILabel *cmtLabel;

@end

@implementation GGTopicCell

+(instancetype)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"GGTopicCell" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setTopicModel:(GGTopicModel *)topicModel
{
    _topicModel = topicModel;
    
    [self.profileImageView gg_setCircularImageWithURL:topicModel.profile_image placeholderImageName:@"defaultUserIcon" cornerRadius:YES backgroundColor:kWhiteColor];

    self.nameLabel.text = topicModel.screen_name;
    self.creatTimeLabel.text = topicModel.created_at;
    self.contentLabel.text = topicModel.text;

    if (topicModel.type == GGTopicTypePicture) {
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        self.pictureView.frame = topicModel.pictureFrame;
        self.pictureView.topicModel = topicModel;
    }else if (topicModel.type == GGTopicTypeVoice) {
        self.pictureView.hidden = YES;
        self.voiceView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.frame = topicModel.voiceFrame;
        self.voiceView.topicModel = topicModel;
    }else if (topicModel.type == GGTopicTypeVideo) {
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = NO;
        self.videoView.frame = topicModel.videoFrame;
        self.videoView.topicModel = topicModel;
    }else {
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
    GGCommentModel *cmtModel = [topicModel.top_cmt firstObject];
    if (cmtModel) {
        self.cmtView.hidden = NO;
        [self.cmtLabel gg_userName:cmtModel.user.username content:cmtModel.content];
    }else {
        self.cmtView.hidden = YES;
    }
    
    [self setupButton:self.dingBtn count:topicModel.ding placeholder:@"顶"];
    [self setupButton:self.hateBtn count:topicModel.hate placeholder:@"踩"];
    [self setupButton:self.repostBtn count:topicModel.ding placeholder:@"转发"];
    [self setupButton:self.commentBtn count:topicModel.ding placeholder:@"评论"];

}

- (void)setupButton:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count >= 10000) {
        CGFloat vaule = ((CGFloat)count) / 10000;
        placeholder = [NSString stringWithFormat:@"%.1f万",vaule];
    }else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%ld",count];
    }
    
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (IBAction)moreAction
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *likeAction = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *reportAction = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler: nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertVc addAction:likeAction];
    [alertVc addAction:reportAction];
    [alertVc addAction:cancelAction];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVc animated:YES completion:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

#pragma makr - lazy
- (GGpictureView *)pictureView
{
    if (_pictureView == nil) {
        _pictureView = [GGpictureView picture];
        [self.contentView addSubview:_pictureView];
    }
    return _pictureView;
}

- (GGTopicVoiceView *)voiceView
{
    if (_voiceView == nil) {
        _voiceView = [GGTopicVoiceView voice];
        [self.contentView addSubview:_voiceView];
    }
    return _voiceView;
}

- (GGTopicVideoView *)videoView
{
    if (_videoView == nil) {
        _videoView = [GGTopicVideoView video];
        [self.contentView addSubview:_videoView];
    }
    return _videoView;
}

@end
