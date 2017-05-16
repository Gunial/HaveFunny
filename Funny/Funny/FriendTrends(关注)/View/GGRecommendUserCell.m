//
//  GGRecommendUserCell.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/21.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGRecommendUserCell.h"
#import "GGRecommendUser.h"
#import "UIImageView+WebCache.h"


@interface GGRecommendUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *fansCount;

@end

@implementation GGRecommendUserCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (IBAction)followButtonClick:(UIButton *)sender
{
    
}

- (void)setUserModel:(GGRecommendUser *)userModel
{
    _userModel = userModel;
    
    [self.headerImage gg_setCircularImageWithURL:userModel.header placeholderImageName:@"defaultUserIcon" cornerRadius:YES backgroundColor:kWhiteColor ];
    
    self.nickName.text = userModel.screen_name;
    self.fansCount.text = [NSString stringWithFormat:@"%zd人订阅",userModel.fans_count];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
