//
//  LoginViewModel.m
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/25.
//  Copyright © 2017年 cj. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

+ (BOOL)checkUsername:(NSString *)username
             password:(NSString *)password
{
    if (username.length > 0 && password.length > 0) {
        return YES;
    }

    //
    // ....
    // other check list
    //

    return NO;
}

@end
