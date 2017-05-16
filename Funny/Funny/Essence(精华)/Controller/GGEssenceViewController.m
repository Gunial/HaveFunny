//
//  GGEssenceViewController.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/19.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGEssenceViewController.h"
#import "GGTotalViewController.h"
#import "GGVideoViewController.h"
#import "GGVoiceViewController.h"
#import "GGPictureViewController.h"
#import "GGStoryViewController.h"

@interface GGEssenceViewController ()<UIScrollViewDelegate>

/** 选中的按钮 */
@property (nonatomic, strong) UIButton *selectedButton;

/** 标签栏 */
@property (nonatomic, strong) UIView *titleView;

/** 标签底部指示器 */
@property (nonatomic, strong) UIView *indicatorView;

/** 内容视图 */
@property (nonatomic, strong) UIScrollView *contentView;

/** 标签按钮数组 */
@property (nonatomic, strong) NSMutableArray *btnsArray;

@end

@implementation GGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APP_DEFAULT_BACKGROUNDCOLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setUpNavigationBar];
    [self setupChildViewControllers];
    // 设置顶部标签栏
    [self setupTitleView];
    
    [self setupContentScrollView];
}

- (void)setupChildViewControllers
{
    GGTotalViewController *totalVc = [[GGTotalViewController alloc] init];
    totalVc.title = @"全部";
    [self addChildViewController:totalVc];
    
    GGVideoViewController *videoVc = [[GGVideoViewController alloc] init];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    
    GGVoiceViewController *voiceVc = [[GGVoiceViewController alloc] init];
    voiceVc.title = @"声音";
    [self addChildViewController:voiceVc];
    
    GGPictureViewController *pictureVc = [[GGPictureViewController alloc] init];
    pictureVc.title = @"图片";
    [self addChildViewController:pictureVc];

    GGStoryViewController *storyVc = [[GGStoryViewController alloc] init];
    storyVc.title = @"段子";
    [self addChildViewController:storyVc];
}

- (void)setupContentScrollView
{
    
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    contentView.contentSize = CGSizeMake(self.view.gg_width * self.btnsArray.count,0);
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    contentView.bounces = NO;
    contentView.showsVerticalScrollIndicator = NO;
    contentView.showsHorizontalScrollIndicator = NO;
    self.contentView = contentView;
    [self.view insertSubview:contentView atIndex:0];

    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

- (void)setupTitleView
{
    [self.view addSubview:self.titleView];
    
    CGFloat buttonWidth = self.view.gg_width / self.childViewControllers.count;
    CGFloat buttonHeight = self.titleView.gg_height - 2;
    
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonWidth * i, 0, buttonWidth, buttonHeight);
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        [button setTitleColor:kDarkTextColor forState:UIControlStateNormal];
        [button setTitleColor:kRedColor forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.btnsArray addObject:button];
        [self.titleView addSubview:button];
        
        if (i == 0) {
            button.selected = YES;
            self.selectedButton = button;
            [button.titleLabel sizeToFit];
            self.indicatorView.gg_width = button.titleLabel.gg_width;
            self.indicatorView.gg_centerX = button.gg_centerX;
        }
    }
}

- (void)titleButtonClick:(UIButton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.indicatorView.gg_width = button.titleLabel.gg_width;
        self.indicatorView.gg_centerX = button.gg_centerX;
    } completion:nil];
    
    NSInteger index = [self.btnsArray indexOfObject:button];
    
    [self.contentView setContentOffset:CGPointMake(self.view.gg_width * index, 0) animated:YES];
}

- (void)setUpNavigationBar
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"nav_item_game_icon" highlightImageName:@"nav_item_game_click_icon" target:self action:@selector(buttonClick)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationButtonRandom" highlightImageName:@"navigationButtonRandomClick" target:self action:nil];
    
}

- (void)buttonClick
{
    NSLogFunc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / self.view.gg_width;
    UIButton *button = [self.btnsArray objectAtIndex:index];
    
    [self titleButtonClick:button];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.gg_width;

    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(scrollView.contentOffset.x, 0, scrollView.gg_width, scrollView.gg_height);
    [scrollView addSubview:vc.view];
}


#pragma mark - getter
- (UIView *)titleView
{
    if (_titleView == nil) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.gg_width, 40)];
        _titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    }
    return _titleView;
}

- (UIView *)indicatorView
{
    if (_indicatorView == nil) {
        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = kRedColor;
        _indicatorView.gg_height = 2;
        _indicatorView.gg_y = self.titleView.gg_height - _indicatorView.gg_height;
        [self.titleView addSubview:_indicatorView];
    }
    return _indicatorView;
}

- (NSMutableArray *)btnsArray
{
    if (_btnsArray == nil) {
        _btnsArray = [NSMutableArray arrayWithCapacity:6];
    }
    return _btnsArray;
}


@end
