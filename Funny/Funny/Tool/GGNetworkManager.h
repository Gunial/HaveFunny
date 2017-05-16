//
//  GGNetworkManager.h
//  Funny
//
//  Created by Mr.Gu on 2017/4/20.
//  Copyright © 2017年 Mr.Gu. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef enum :NSUInteger {
    GET,
    POST
}GGRequsetMethod;

@interface GGNetworkManager : AFHTTPSessionManager

/**
 网络工具类 单例
 */
+ (instancetype)shareManager;

/// 网络请求
///
/// @param method  请求方式
/// @param urlString  请求地址
/// @param success 成功回调
/// @param failure 失败回调
- (void)httpRequest:(GGRequsetMethod)method
          urlString:(NSString *)urlString
         parameters:(NSDictionary *)parameters
            success:(void (^)(id response))success
            failure:(void(^)(NSError *error))failure;

@end
