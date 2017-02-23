//
//  APIManager.m
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/24.
//  Copyright © 2017年 cj. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager

+ (APIManager *)sharedManager
{
    static dispatch_once_t onceToken;
    static APIManager *sharedManager;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@"http://52.197.192.141:3443/"];
        sharedManager = [[self alloc] initWithBaseURL:url];
    });
    return sharedManager;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
               completion:(void (^)(NSDictionary * _Nullable dictionary, NSError * _Nullable error))completion
{
    if (!username || !password) { return; }

    NSString *URLString = @"";
    NSDictionary *body = @{@"name":username,
                           @"pwd":password,
                           };
    [self POST:URLString parameters:body progress:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        if (!completion) { return; }

        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            completion(responseObject, nil);
        } else {
            completion(nil, [NSError errorWithDomain:@"foo error format domain"
                                                code:9527
                                            userInfo:nil]);
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        if (!completion) { return; }

        completion(nil, error);
    }];
}

@end
