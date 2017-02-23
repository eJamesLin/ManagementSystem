//
//  AppAccount.h
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/24.
//  Copyright © 2017年 cj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface AppAccount : NSObject

+ (instancetype)sharedAppAccount;

@property (nonatomic, copy, nullable) NSString *authToken;

@end
NS_ASSUME_NONNULL_END
