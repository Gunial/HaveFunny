//
//  GGNetworkManager.m
//  Funny
//
//  Created by Mr.Gu on 2017/4/20.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import "GGNetworkManager.h"

@implementation GGNetworkManager

+ (instancetype)shareManager
{
    static GGNetworkManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        NSURL *baseURL = [NSURL URLWithString:@""];
        _instance = [[GGNetworkManager alloc] initWithBaseURL:nil];
        _instance.requestSerializer.timeoutInterval = 30;
        _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",  @"text/plain", nil];
    });
    return _instance;
}

- (void)httpRequest:(GGRequsetMethod)method urlString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(void (^)(id response))success failure:(void(^)(NSError *error))failure
{
    if (method == GET) {
        [self GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success != nil) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure != nil) {
                failure(error);
            }
        }];
    }else {
        [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success != nil) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure != nil) {
                failure(error);
            }
        }];
    }
}


@end

