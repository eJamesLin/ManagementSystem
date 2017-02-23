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
    if (![self checkUsername:self.usernameLabel.text password:self.passwordLabel.text]) { return; }

    [[APIManager sharedManager] loginWithUsername:self.usernameLabel.text
                                         password:self.passwordLabel.text
                                       completion:^(NSDictionary * _Nullable dictionary, NSError * _Nullable error) {

        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                [AppAccount sharedAppAccount].authToken = dictionary[@"token"][@"token"];
                if (self.loginDidSuccessBlock) {
                    self.loginDidSuccessBlock();
                }
            } else {
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
        });
    }];
}

- (BOOL)checkUsername:(NSString *)username
             password:(NSString *)password
{
    if (self.usernameLabel.text.length > 0 && self.passwordLabel.text.length > 0) {
        return YES;
    }

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"請輸入帳號密碼"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];
    [self presentViewController:alert
                       animated:YES
                     completion:nil];

    //
    // ....
    // other check list
    //


    return NO;
}

@end
