//
//  FunnyDefine.h
//  Funny
//
//  Created by Mr.Gu on 2017/4/19.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#ifndef FunnyDefine_h
#define FunnyDefine_h

#define BaseURL                 @"http://api.budejie.com/api/api_open.php"

#define kScreenWidth            [UIScreen mainScreen].bounds.size.width
#define kScreenHeight           [UIScreen mainScreen].bounds.size.height

/**
 * 颜色设置
 */
#define RGBACOLOR(r,g,b,a)      [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define RANDOMCOLOR             [UIColor colorWithRed:arc4random() % 256 /255.0 green:arc4random() % 256 /255.0 blue:arc4random() % 256 /255.0 alpha:1.0]

#define kWhiteColor             [UIColor whiteColor]
#define kRedColor               [UIColor redColor]
#define kLightGrayColor         [UIColor lightGrayColor]
#define kDarkTextColor          [UIColor darkTextColor]
#define kBlackColor             [UIColor blackColor]
#define kDarkGrayColor          [UIColor darkGrayColor]
#define kGrayColor              [UIColor grayColor]
#define kBlueColor              [UIColor blueColor]
#define kOrangeColor            [UIColor orangeColor]
#define kClearColor             [UIColor clearColor]

#define APP_DEFAULT_BACKGROUNDCOLOR   RGBACOLOR(215, 215, 215, 1.0)

// 输出调试
#ifdef DEBUG
#define NSLog(format, ...)      printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

#define NSLogFunc               NSLog(@"%s",__func__)

//  强弱引用
#define WeakSelf(type)          __weak typeof(type) weak##type = type;
#define StrongSelf(type)        __strong typeof(type) type = weak##type;

/**
 *  调用 KIphoneSize_Widith(100) 6的宽度 会根据456给出不同宽度，
 高度同上
 *  @param iphone6p 100*1.104
 *  @param iphone6  100
 *  @param iphone5s 100*0.853
 *  @param iphone4s 100*0.853
 *  @return
 */
//适配宏 根据屏幕尺寸来判断当前手机型号
#define KScreenSize [UIScreen mainScreen].bounds.size
#define IsIphone6P KScreenSize.width==414
#define IsIphone6 KScreenSize.width==375
#define IsIphone5S KScreenSize.height==568
//456字体大小  KIOS_Iphone456(iphone6p,iphone6,iphone5s,iphone4s)
#define KIOS_Iphone456(iphone6p,iphone6,iphone5s,iphone4s) (IsIphone6P?iphone6p:(IsIphone6?iphone6:(IsIphone5S?iphone5s:iphone4s)))
//宽  KIphoneSize_Widith(iphone6)  高 KIphoneSize_Height(iphone6)
#define KIphoneSize_Widith(iphone6)  (IsIphone6P?1.104*iphone6:(IsIphone6?iphone6:(IsIphone5S?0.853*iphone6:0.853*iphone6)))
#define KIphoneSize_Height(iphone6)  (IsIphone6P?1.103*iphone6:(IsIphone6?iphone6:(IsIphone5S?0.851*iphone6:0.720*iphone6)))

#endif /* FunnyDefine_h */
