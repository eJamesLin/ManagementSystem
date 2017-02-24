//
//  LoginViewController.m
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/23.
//  Copyright © 2017年 cj. All rights reserved.
//

#import "LoginViewController.h"
#import "APIManager.h"
#import "AppAccount.h"
#import "LoginViewModel.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#if DEBUG
- (void)dealloc
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
#endif

- (IBAction)loginTapped:(id)sender
{
    if (![LoginViewModel checkUsername:self.usernameLabel.text password:self.passwordLabel.text]) {
        [self showInputError];
        return;
    }

    NSString *username = self.usernameLabel.text;
    NSString *pwd = self.passwordLabel.text;

    [AppAccount sharedAppAccount].username = username;
    [AppAccount sharedAppAccount].pwd = [MainNavigationController encryptString:pwd];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [[APIManager sharedManager] loginWithUsername:username
                                         password:pwd
                                       completion:^(TokenModel * _Nullable token, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{

            [MBProgressHUD hideHUDForView:self.view animated:YES];

            if (!error) {
                /*
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hant_TW"];
                dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                NSLog(@"expired at %@", [dateFormatter stringFromDate:token.expiredDate]);
                 */

                [AppAccount sharedAppAccount].authToken = token;
                if (self.loginDidSuccessBlock) {
                    self.loginDidSuccessBlock();
                }
            } else {
                [self showServerLoginWithError:error];
            }
        });
    }];
}

- (void)showServerLoginWithError:(NSError *)error
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"error"
                                                                   message:error.localizedDescription
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];
    [self presentViewController:alert
                       animated:YES
                     completion:nil];
}

- (void)showInputError
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"帳密輸入有誤"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];
    [self presentViewController:alert
                       animated:YES
                     completion:nil];
}

@end
