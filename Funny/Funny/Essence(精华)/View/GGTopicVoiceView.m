//
//  GGTopicVoiceView.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/28.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGTopicVoiceView.h"
#import "GGTopicModel.h"

#import <UIImageView+WebCache.h>

@interface GGTopicVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCount;

@property (weak, nonatomic) IBOutlet UILabel *playTime;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end

@implementation GGTopicVoiceView


+ (instancetype)voice
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopicModel:(GGTopicModel *)topicModel
{
    _topicModel = topicModel;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicModel.image0] placeholderImage:nil];
    
    self.playCount.text = [NSString stringWithFormat:@"%ld播放", topicModel.playfcount];
    
    NSInteger minute = topicModel.voicetime / 60;
    NSInteger second = topicModel.voicetime % 60;
    
    self.playTime.text = [NSString stringWithFormat:@"%02ld:%02ld", minute, second];
}



- (IBAction)playMusicAction:(UIButton *)sender
{
    
    
}


@end
