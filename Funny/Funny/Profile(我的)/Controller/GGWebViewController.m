//
//  GGWebViewController.m
//  Funny
//
//  Created by Mr.Gu on 2017/5/10.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGWebViewController.h"

@interface GGWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;

@end

@implementation GGWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.squareModel.url]]];
}

- (IBAction)goBackAction:(id)sender {
    [self.webView goBack];
}
- (IBAction)goForwardAction:(id)sender {
    [self.webView goForward];
}
- (IBAction)refreshAction:(id)sender {
    [self.webView reload];
}

#pragma mark - <UIWebViewDelegate>

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.goBackItem.enabled = webView.canGoBack;
    self.goForwardItem.enabled = webView.canGoForward;
}

@end
