//
//  GGSquareCell.m
//  Funny
//
//  Created by Mr.Gu on 2017/5/10.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGSquareCell.h"
#import "GGSquareModel.h"
#import <UIImageView+WebCache.h>

@interface GGSquareCell ()

/** 图片 */
@property (nonatomic, strong) UIImageView *imageView;

/** 文字 */
@property (nonatomic, strong) UILabel *label;

@end

@implementation GGSquareCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.label];
}


- (void)setSquareModel:(GGSquareModel *)squareModel
{
    _squareModel = squareModel;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:squareModel.icon] placeholderImage:nil];
    self.label.text = squareModel.name;
}

#pragma mark - lazy
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.gg_y = self.gg_height * 0.15;
        _imageView.gg_width = self.gg_width * 0.5;
        _imageView.gg_height =self.gg_width * 0.5;
        _imageView.gg_centerX = self.gg_width * 0.5;
    }
    return _imageView;
}

- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.gg_y = CGRectGetMaxY(self.imageView.frame);
        _label.gg_width = self.contentView.gg_width;
        _label.gg_height = self.gg_height * 0.35;
        _label.textColor = kDarkTextColor;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:KIphoneSize_Widith(14)];
    }
    return _label;
}

@end
