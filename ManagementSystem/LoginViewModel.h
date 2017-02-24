//
//  LoginViewModel.h
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/25.
//  Copyright © 2017年 cj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginViewModel : NSObject

+ (BOOL)checkUsername:(NSString *)username
             password:(NSString *)password;

@end
