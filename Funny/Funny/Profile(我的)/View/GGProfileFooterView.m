//
//  GGProfileFooterView.m
//  Funny
//
//  Created by Mr.Gu on 2017/5/10.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGProfileFooterView.h"
#import "GGWebViewController.h"

#import "GGSquareCell.h"

#import "GGSquareModel.h"

#import <MJExtension.h>
#import <UIButton+WebCache.h>

#define FooterViewHeight  kScreenWidth / 5 * 2

@interface GGProfileFooterView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

/** 数据源 */
@property (nonatomic, strong) NSArray *dataSource;

//@property (nonatomic, strong) UIPageControl *pageControl;

@end

static NSString *SquareCellID = @"GGSquareCell";
@implementation GGProfileFooterView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        self.gg_height = FooterViewHeight;
        self.gg_width = kScreenWidth;
        [self setupSubViews];
        
        [self loadData];
    }
    return self;
}

- (void)setupSubViews
{
    
//    NSLog(@"%@",NSStringFromCGRect(self.frame));

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.itemSize = CGSizeMake(kScreenWidth / 5, kScreenWidth / 5);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    [collectionView registerClass:[GGSquareCell class] forCellWithReuseIdentifier:SquareCellID];
    collectionView.backgroundColor = kWhiteColor;
    self.collectionView = collectionView;
    
    [self addSubview:collectionView];
    
}


- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";

    [[GGNetworkManager shareManager] httpRequest:GET urlString:BaseURL parameters:params success:^(NSDictionary * response) {
        self.dataSource = [GGSquareModel mj_objectArrayWithKeyValuesArray:response[@"square_list"]];
        
//        self.pageControl.numberOfPages = self.dataSource.count /(10 -1) + 1;
        
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
    }];
    
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GGSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SquareCellID forIndexPath:indexPath];
    cell.squareModel = self.dataSource[indexPath.row];
        
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GGSquareModel *squareModel = self.dataSource[indexPath.row];
    
    if ([squareModel.url hasPrefix:@"http"]) {
        GGWebViewController *webVc = [[GGWebViewController alloc] init];
        webVc.title = squareModel.name;
        webVc.squareModel = squareModel;
        
        UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        UINavigationController *navVc = (UINavigationController *)tabBarVc.selectedViewController;
        
        [navVc pushViewController:webVc animated:YES];
    }else {
        NSLog(@"%@",squareModel.url);
    }
}


@end
