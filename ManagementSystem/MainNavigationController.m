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

static NSString * const StoryBoardMain = @"Main"; //Main.storyboard

@interface MainNavigationController ()

@property (nonatomic, strong, nonnull) MenuViewController *menuVC;
@property (nonatomic, strong, nullable) MemberListViewController *memberListVC;
@property (nonatomic, strong, nullable) CreateNewMemberViewController *createNewMemberVC;
@property (nonatomic, strong, nullable) LoginViewController *loginVC;

@end

@implementation MainNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.viewControllers = @[self.loginVC];
    self.leftMenu = self.menuVC;
}

- (void)_setupMenuActions:(MenuViewController *)menu
{
    __weak __typeof(self) weakSelf = self;

    // Menu 按登出
    menu.didTapLogoutClosure = ^{
        [AppAccount sharedAppAccount].authToken = nil;

        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf closeMenuWithCompletion:^{

            // switch back to login
            strongSelf.viewControllers = @[strongSelf.loginVC];

            //
            strongSelf.createNewMemberVC = nil;
            strongSelf.memberListVC = nil;
        }];
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
