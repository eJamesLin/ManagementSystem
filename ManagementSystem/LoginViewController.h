//
//  LoginViewController.h
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/23.
//  Copyright © 2017年 cj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface LoginViewController : UIViewController

@property (nonatomic, copy, nullable) void (^loginDidSuccessBlock)(void);

@end
NS_ASSUME_NONNULL_END
