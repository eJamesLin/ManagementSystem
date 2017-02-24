//
//  MainNavigationController.h
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/23.
//  Copyright © 2017年 cj. All rights reserved.
//

#import <iOS-Slide-Menu/SlideNavigationController.h>

@protocol MainNavigationControllerDelegate <NSObject>
@optional
- (void)didExtendToken;
@end

@interface MainNavigationController : SlideNavigationController

@property (nonatomic, weak) id <MainNavigationControllerDelegate> mainDelegate;

- (void)extendToken;

@end
