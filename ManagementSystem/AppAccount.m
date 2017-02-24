//
//  AppAccount.m
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/24.
//  Copyright © 2017年 cj. All rights reserved.
//

#import "AppAccount.h"

@implementation AppAccount

+ (instancetype)sharedAppAccount
{
    static dispatch_once_t onceToken;
    static AppAccount *shared;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (void)setAuthToken:(TokenModel *)authToken
{
    _authToken = authToken;
    [[APIManager sharedManager].requestSerializer setValue:authToken.token forHTTPHeaderField:@"Authorization"];
}

@end
