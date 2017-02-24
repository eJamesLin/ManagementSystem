//
//  MainNavigationController.m
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/23.
//  Copyright © 2017年 cj. All rights reserved.
//

#import "MainNavigationController.h"
#import "AppAccount.h"
#import "LoginViewController.h"
#import "LoginViewModel.h"

static NSString * const StoryBoardMain = @"Main"; //Main.storyboard
static NSInteger const ExtendTokenLimit = 2;

@interface MainNavigationController ()

@property (nonatomic, strong, nonnull) MenuViewController *menuVC;
@property (nonatomic, strong, nullable) MemberListViewController *memberListVC;
@property (nonatomic, strong, nullable) CreateNewMemberViewController *createNewMemberVC;
@property (nonatomic, strong, nullable) LoginViewController *loginVC;

@property (nonatomic) NSInteger extendTokenTimes;

@end

@implementation MainNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.extendTokenTimes = 0;

    self.viewControllers = @[self.loginVC];
    self.leftMenu = self.menuVC;
}

- (void)_setupMenuActions:(MenuViewController *)menu
{
    __weak __typeof(self) weakSelf = self;

    // Menu 按登出
    menu.didTapLogoutClosure = ^{
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf logout];
    };

    // Menu 按會員列表
    menu.didTapMemberListClosure = ^{
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf popAllAndSwitchToViewController:strongSelf.memberListVC withCompletion:nil];
    };

    // Menu 按新增會員
    menu.didTapNewMemberClosure = ^{
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf popAllAndSwitchToViewController:strongSelf.createNewMemberVC withCompletion:nil];
    };
}

// 登入成功後的流程
- (void)_setupLoginAction:(LoginViewController *)vc
{
    __weak __typeof(self) weakSelf = self;
    vc.loginDidSuccessBlock = ^{
        __strong __typeof(weakSelf) strongSelf = weakSelf;

        // switch to member list
        strongSelf.menuVC.view.hidden = YES;
        [UIView transitionWithView:[MainNavigationController sharedInstance].view
                          duration:0.5f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            [MainNavigationController sharedInstance].viewControllers = @[strongSelf.memberListVC];
                        }
                        completion:^(BOOL finished) {
                            strongSelf.menuVC.view.hidden = NO;
                            strongSelf.loginVC = nil;
                        }];
    };
}

// Extend Token
- (void)extendToken
{
    if (self.extendTokenTimes >= ExtendTokenLimit) {
        [self tokenDidExpired];
        return;
    }
    self.extendTokenTimes++;

    NSString *username = [AppAccount sharedAppAccount].username;
    NSString *password = [AppAccount sharedAppAccount].pwd;
    if (![LoginViewModel checkUsername:username password:password]) {
        [self tokenDidExpired];
        return;
    }

    [[APIManager sharedManager] loginWithUsername:username
                                         password:password
                                       completion:^(TokenModel * _Nullable token, NSError * _Nullable error) {
                                           if (!error) {
                                               [AppAccount sharedAppAccount].authToken = token;
                                               if ([self.mainDelegate respondsToSelector:@selector(didExtendToken)]) {
                                                   [self.mainDelegate didExtendToken];
                                               }
                                           } else {
                                               [self tokenDidExpired];
                                           }
                                       }];
}

- (void)tokenDidExpired
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"token expired"
                                                                       message:@"請重新登入"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
                                                    [self logout];
                                                }]];
        [self presentViewController:alert animated:YES completion:nil];
    });
}

- (void)logout
{
    [AppAccount sharedAppAccount].authToken = nil;

    __weak __typeof(self) weakSelf = self;
    [self closeMenuWithCompletion:^{
        __strong __typeof(weakSelf) strongSelf = weakSelf;

        // switch back to login
        strongSelf.viewControllers = @[strongSelf.loginVC];

        //
        strongSelf.createNewMemberVC = nil;
        strongSelf.memberListVC = nil;
    }];
}

#pragma mark - Lazy initialization

- (MemberListViewController *)memberListVC
{
    if (!_memberListVC) {
        _memberListVC = [[MemberListViewController alloc] init];
    }
    return _memberListVC;
}

- (CreateNewMemberViewController *)createNewMemberVC
{
    if (!_createNewMemberVC) {
        _createNewMemberVC = [[CreateNewMemberViewController alloc] init];
    }
    return _createNewMemberVC;
}

- (LoginViewController *)loginVC
{
    if (!_loginVC) {
        _loginVC = [[UIStoryboard storyboardWithName:StoryBoardMain bundle:nil]instantiateViewControllerWithIdentifier:NSStringFromClass([LoginViewController class])];
        [self _setupLoginAction:_loginVC];
    }
    return _loginVC;
}

- (MenuViewController *)menuVC
{
    if (!_menuVC) {
        _menuVC = [[MenuViewController alloc] init];
        [self _setupMenuActions:_menuVC];
    }
    return _menuVC;
}

@end
