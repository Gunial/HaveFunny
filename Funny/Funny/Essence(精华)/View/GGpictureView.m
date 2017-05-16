//
//  GGpictureView.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/26.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGpictureView.h"
#import "GGShowPictureViewController.h"

#import "GGTopicModel.h"

#import <UIImageView+WebCache.h>
#import <FLAnimatedImageView.h>
#import "GGProgressView.h"

@interface GGpictureView ()
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureBtn;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;

@end

@implementation GGpictureView


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
    /** 给图片添加单击手势 */
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageView)];
    [self.imageView addGestureRecognizer:tapGesture];
}

- (void)clickImageView
{
    GGShowPictureViewController *showPictureVc = [[GGShowPictureViewController alloc] init];
    showPictureVc.topicModel = self.topicModel;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPictureVc animated:YES completion:nil];
}

+ (instancetype)picture
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setTopicModel:(GGTopicModel *)topicModel
{
    _topicModel = topicModel;
    
    self.gifImageView.hidden = !topicModel.is_gif;
    self.seeBigPictureBtn.hidden = !topicModel.is_big;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicModel.cdn_img] placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {        
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        
        if (!topicModel.is_big) return;
        
        UIGraphicsBeginImageContext(topicModel.pictureFrame.size);
        
        CGFloat contextW = topicModel.pictureFrame.size.width;
        CGFloat contextH = topicModel.height / topicModel.width * contextW;
        
        [image drawInRect:CGRectMake(0, 0, contextW, contextH)];
        
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }];
    
    if (topicModel.is_big) {
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    }else {
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = YES;
    }
}

@end
