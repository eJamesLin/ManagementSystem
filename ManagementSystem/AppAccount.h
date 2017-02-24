//
//  AppAccount.h
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/24.
//  Copyright © 2017年 cj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TokenModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface AppAccount : NSObject

+ (instancetype)sharedAppAccount;

@property (nonatomic, strong, nullable) TokenModel *authToken;

// encrypt later
@property (nonatomic, copy, nullable) NSString *username;
@property (nonatomic, copy, nullable) NSString *pwd;

@end
NS_ASSUME_NONNULL_END
