//
//  GGProgressView.h
//  Funny
//
//  Created by Mr.Gu on 2017/4/27.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import <DALabeledCircularProgressView.h>

@interface GGProgressView : DALabeledCircularProgressView

- (void)gg_setupProgress:(CGFloat)progress animated:(BOOL)animated;

@end
