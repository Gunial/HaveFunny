//
//  GGProfileCell.m
//  Funny
//
//  Created by Mr.Gu on 2017/5/10.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGProfileCell.h"

@implementation GGProfileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.gg_width = 30;
    self.imageView.gg_height = 30;
    self.imageView.gg_centerY = self.contentView.gg_height * 0.5;
    [self.imageView.image gg_asyncDrawImageWithSize:self.imageView.bounds.size cornerRadius:YES backgroundColor:kWhiteColor completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
}


@end
