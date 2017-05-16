//
//  GGCommentCell.m
//  Funny
//
//  Created by Mr.Gu on 2017/5/9.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGCommentCell.h"
#import "GGCommentModel.h"
#import "GGUserModel.h"

@interface GGCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLikeCount;

@end

@implementation GGCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.totalLikeCount.layer.cornerRadius = 3;
    self.totalLikeCount.layer.masksToBounds = YES;    
    self.likeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.likeButton setTitleColor:kRedColor forState:UIControlStateSelected];
}
- (IBAction)likeAction:(UIButton *)sender
{
    sender.selected = YES;
    self.commentModel.isSelected = YES;
}

- (void)setCommentModel:(GGCommentModel *)commentModel
{
    _commentModel = commentModel;
    
    [self.headerImageView gg_setCircularImageWithURL:commentModel.user.profile_image placeholderImageName:@"defaultUserIcon" cornerRadius:YES backgroundColor:kWhiteColor];
    if ([commentModel.user.sex isEqualToString:@"m"]) {
        self.sexImageView.image = [UIImage imageNamed:@"Profile_manIcon"];
    }else {
        self.sexImageView.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
    self.nickNameLabel.text = commentModel.user.username;
    
    self.likeButton.selected = commentModel.isSelected;
    
    self.contentLabel.text = commentModel.content;
}



@end
