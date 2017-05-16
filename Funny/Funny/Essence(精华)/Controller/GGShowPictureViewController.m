//
//  GGShowPictureViewController.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/27.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGShowPictureViewController.h"
#import "GGTopicModel.h"

#import <FLAnimatedImageView.h>
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface GGShowPictureViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

/** 图片框 */
@property (nonatomic, strong) FLAnimatedImageView *imageView;

@end

@implementation GGShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.scrollView addSubview:self.imageView];
    
    
    CGFloat pictureWidth = kScreenWidth;
    CGFloat pictureHeight = (self.topicModel.height / self.topicModel.width) * pictureWidth;
    
    if (pictureHeight > kScreenHeight) {
        self.imageView.frame = CGRectMake(0, 0  , pictureWidth, pictureHeight);
        self.scrollView.contentSize = CGSizeMake(0, pictureHeight);
    }else{
        self.imageView.bounds = CGRectMake(0, 0  , pictureWidth, pictureHeight);
        self.imageView.center = CGPointMake(kScreenWidth * 0.5, kScreenHeight * 0.5);
    }
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topicModel.cdn_img] placeholderImage:nil];
}

- (IBAction)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)savePicture
{
    
    if (!self.imageView.image) {
        [SVProgressHUD showWithStatus:@"图片还在加载中"];
        return;
    }
    
    
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"图片保存失败"];
    }else
    {
        [SVProgressHUD showSuccessWithStatus:@"图片保存成功"];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - lazy
- (FLAnimatedImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[FLAnimatedImageView alloc] init];
    }
    return _imageView;
}

@end
