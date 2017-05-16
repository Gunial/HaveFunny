//
//  GGLoginRegisterViewController.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/24.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGLoginRegisterViewController.h"

@interface GGLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingLayoutContraint;
@end

@implementation GGLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/** 注册账号 */
- (IBAction)registerAccount:(UIButton *)button
{
    // 退出键盘
    [self.view endEditing:YES];
    
    if (self.leadingLayoutContraint.constant == 0) {
        self.leadingLayoutContraint.constant = - self.view.gg_width;
        button.selected = YES;
    }else {
        self.leadingLayoutContraint.constant = 0;
        button.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}


/** 忘记密码 */
- (IBAction)forgetPassword
{
    NSLogFunc;
}

/** 快速登录 */
- (IBAction)quicklyLogin
{
    NSLogFunc;
}

- (IBAction)dismissViewController
{
    // 退出键盘
    [self.view endEditing:YES];
     
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 改变状态栏颜色 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
