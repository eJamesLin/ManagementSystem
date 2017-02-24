//
//  APIManager.m
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/24.
//  Copyright © 2017年 cj. All rights reserved.
//

#import "APIManager.h"
#import <Mantle/Mantle.h>
#import "AppAccount.h"

static NSString * const BaseURLString = @"http://52.197.192.141:3443/";

@implementation APIManager

+ (APIManager *)sharedManager
{
    static dispatch_once_t onceToken;
    static APIManager *sharedManager;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:BaseURLString];
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
               completion:(void (^)(TokenModel * _Nullable token, NSError * _Nullable error))completion
{
    if (!username || !password) { return; }
    if (!completion) { return; }

    NSString *URLString = @"";
    NSDictionary *body = @{@"name":username,
                           @"pwd":password,
                           };
    [self POST:URLString parameters:body progress:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        if (!completion) { return; }

        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSError *error = nil;
            TokenModel *token = [MTLJSONAdapter modelOfClass:[TokenModel class]
                                          fromJSONDictionary:responseObject[@"token"]
                                                       error:&error];
            completion(token, error);
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

- (void)getMemberListWithCompletion:(void (^)(NSArray<MemberModel *> * _Nullable dictionary, NSError * _Nullable error))completion
{
    if (!completion) { return; }
    NSString *URLString = @"member";

    [self GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        if (!completion) { return; }

        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSError *error = nil;
            NSArray *models = [MTLJSONAdapter modelsOfClass:[MemberModel class]
                                              fromJSONArray:responseObject[@"data"] error:&error];
            completion(models, error);
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

- (void)createNewMemberWithUsername:(NSString *)username
                         completion:(void (^)(NSError * _Nullable error))completion
{
    if (!username) { return; }
    if (!completion) { return; }

    NSString *URLString = @"member";
    NSDictionary *body = @{@"name":username};

    [self POST:URLString parameters:body progress:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        if (!completion) { return; }

        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            completion(nil);
        } else {
            completion([NSError errorWithDomain:@"foo error format domain"
                                                code:9527
                                            userInfo:nil]);
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        if (!completion) { return; }

        completion(error);
    }];
}


@end
