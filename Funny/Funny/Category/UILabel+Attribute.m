//
//  UILabel+Attribute.m
//  Funny
//
//  Created by Mr.Gu on 2017/5/8.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "UILabel+Attribute.h"

@implementation UILabel (Attribute)

- (void)gg_userName:(NSString *)username content:(NSString *)content
{
    NSMutableAttributedString *comment = [[NSMutableAttributedString alloc] initWithString:username attributes:@{NSForegroundColorAttributeName : RGBACOLOR(0, 100, 255, 1.0), NSFontAttributeName : [UIFont systemFontOfSize:14]}];

    NSAttributedString *text = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@": %@",content] attributes:@{NSForegroundColorAttributeName : kDarkTextColor, NSFontAttributeName : [UIFont systemFontOfSize:14]}];
    
    [comment appendAttributedString:text];
    
    [self setAttributedText:comment];
}

@end
