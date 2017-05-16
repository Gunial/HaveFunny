//
//  GGTextField.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/24.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGTextField.h"
#import <objc/runtime.h>

@implementation GGTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.tintColor = self.textColor;
    [self resignFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    [self setValue:kWhiteColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
    
}

- (BOOL)resignFirstResponder
{
    [self setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}


@end
