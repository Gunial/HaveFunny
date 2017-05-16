//
//  GGTopicVideoView.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/28.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGTopicVideoView.h"
#import "GGTopicModel.h"
#import <MediaPlayer/MediaPlayer.h>
#import <UIImageView+WebCache.h>

@interface GGTopicVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *playCount;

@property (weak, nonatomic) IBOutlet UILabel *playTime;

@end

@implementation GGTopicVideoView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}


+ (instancetype)video
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)playVideoAction
{
    MPMoviePlayerViewController *playVc = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:self.topicModel.videouri]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentMoviePlayerViewControllerAnimated:playVc];

    NSLog(@"播放视频");
}

- (void)setTopicModel:(GGTopicModel *)topicModel
{
    _topicModel = topicModel;
    
    _topicModel = topicModel;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicModel.image0] placeholderImage:nil];
    
    self.playCount.text = [NSString stringWithFormat:@"%ld播放", topicModel.playfcount];
    
    NSInteger minute = topicModel.videotime / 60;
    NSInteger second = topicModel.videotime % 60;
    
    self.playTime.text = [NSString stringWithFormat:@"%02ld:%02ld", minute, second];
}

@end
