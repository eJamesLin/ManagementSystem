//
//  APIManager.h
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/24.
//  Copyright © 2017年 cj. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN
@interface APIManager : AFHTTPSessionManager

+ (APIManager *)sharedManager;

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
               completion:(void (^)(NSDictionary * _Nullable dictionary, NSError * _Nullable error))completion;

@end
NS_ASSUME_NONNULL_END