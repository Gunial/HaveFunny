//
//  GGPublishViewController.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/19.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGPublishViewController.h"

#import "GGVerticalButton.h"

@interface GGPublishViewController ()

/** 按钮集合 */
@property (nonatomic, strong) NSMutableArray *buttonArr;
/** 标语图片 */
@property (nonatomic, strong) UIImageView *sloganImageView;

@end

@implementation GGPublishViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupImageButton];
    [self setupSloganImageView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (int i = 0 ; i < self.buttonArr.count; i ++) {
        UIButton *button = self.buttonArr[i];
        
        [UIView animateWithDuration:0.5 delay:i * 0.05 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            button.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.5 animations:^{
                self.sloganImageView.transform = CGAffineTransformIdentity;
            }];
        }];
        
    }
}

- (void)setupImageButton
{
    NSArray *imagesArr = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titlesArr = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 40;
    NSInteger maxCol = 3;
    CGFloat buttonStartY = (kScreenHeight - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = KIphoneSize_Widith(20);
    CGFloat margin = (kScreenWidth - 2 * buttonStartX - 3 * buttonW)/(maxCol - 1);
    
    for (int i = 0; i < imagesArr.count; i ++) {
        
        int row = i % maxCol;
        int col = i / maxCol;
        
        GGVerticalButton *button = [[GGVerticalButton alloc] init];
        button.titleLabel.font = [UIFont systemFontOfSize:KIphoneSize_Height(16)];
        [button setTitle:titlesArr[i] forState:UIControlStateNormal];
        [button setTitleColor:kGrayColor forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imagesArr[i]] forState:UIControlStateNormal];
        
        button.gg_x = buttonStartX + (buttonW + margin) * row;
        button.gg_y = buttonStartY + buttonH * col;
        button.gg_width = buttonW;
        button.gg_height = buttonH;
        
        [self.view addSubview:button];
        
        button.transform = CGAffineTransformMakeTranslation(0, - kScreenHeight);
        
        [self.buttonArr addObject:button];
    }
}

- (void)setupSloganImageView
{
    [self.view addSubview:self.sloganImageView];
    
    self.sloganImageView.transform = CGAffineTransformMakeTranslation(0, -kScreenHeight);
}

- (IBAction)cancelButtonClick:(UIButton *)sender
{
    
    for (int i = 0 ; i < self.buttonArr.count; i ++) {
        UIButton *button = self.buttonArr[i];
        
        [UIView animateWithDuration:0.5 delay:i * 0.05 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            button.transform = CGAffineTransformMakeTranslation(0, kScreenHeight);
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.5 animations:^{
                self.sloganImageView.transform = CGAffineTransformMakeTranslation(0, kScreenHeight);
            } completion:^(BOOL finished) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }];
    }
}

#pragma mark - lazy

- (UIImageView *)sloganImageView
{
    if (_sloganImageView == nil) {
        _sloganImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
        _sloganImageView.gg_y = KIphoneSize_Height(100);
        _sloganImageView.gg_centerX = kScreenWidth * 0.5;
    }
    return _sloganImageView;
}

- (NSMutableArray *)buttonArr
{
    if (_buttonArr == nil) {
        _buttonArr = [NSMutableArray array];
    }
    return _buttonArr;
}


@end
