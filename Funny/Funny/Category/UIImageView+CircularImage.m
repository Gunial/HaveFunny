//
//  UIImageView+CircularImage.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/25.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "UIImageView+CircularImage.h"
#import "UIImage+CircularImage.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (CircularImage)

- (void)gg_setCircularImageWithURL:(NSString *)urlString placeholderImageName:(NSString *)placeholderImageName cornerRadius:(BOOL)corner backgroundColor:(UIColor *)color
{

    CGSize size = self.gg_size;
    
    UIImage *placeholderImage = [[UIImage alloc] init];
    if (placeholderImageName) {
        placeholderImage = [UIImage imageNamed:placeholderImageName];
    }
    
    if (!urlString) {
        [placeholderImage gg_asyncDrawImageWithSize:size cornerRadius:corner backgroundColor:color completion:^(UIImage *image) {
            self.image = image;
        }];
        
        return;
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    if (!corner) {
        [self sd_setImageWithURL:url placeholderImage:placeholderImage];
        return;
    }else {
        [self sd_setImageWithURL:url placeholderImage:placeholderImage options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            [image gg_asyncDrawImageWithSize:size cornerRadius:corner backgroundColor:color completion:^(UIImage *image) {
                self.image = image;
            }];
        }];
    }
}


- (void)gg_setCircularImage:(UIImage *)image cornerRadius:(BOOL)corner backgroundColor:(UIColor *)color
{
    CGSize size = self.gg_size;
    
    [image gg_asyncDrawImageWithSize:size cornerRadius:corner backgroundColor:color completion:^(UIImage *image) {
        self.image = image;
    }];
}

@end
