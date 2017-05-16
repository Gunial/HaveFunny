//
//  GGRecommendCategoryCell.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/20.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGRecommendCategoryCell.h"
#import "GGRecommendCategory.h"

@interface GGRecommendCategoryCell ()

@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation GGRecommendCategoryCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.textLabel.font = [UIFont systemFontOfSize:16];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setCategory:(GGRecommendCategory *)category
{
    _category = category;
    self.textLabel.text = category.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? RGBACOLOR(219, 21, 26, 1.0) : RGBACOLOR(78, 78, 78, 1.0);
}

@end
