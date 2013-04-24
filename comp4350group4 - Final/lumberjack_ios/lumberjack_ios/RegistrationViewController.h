//
//  lumberjack_iosRegistrationViewController.h
//  LumberJack
//
//  Created by Shashank Chaudhary on 2013-03-09.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblUsernameError;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirm;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblPasswordError;
@property (weak, nonatomic) IBOutlet UILabel *lblConfirmError;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
- (IBAction)signUp:(id)sender;
- (IBAction) confirmChanged;
- (BOOL) signUpAction:(id)sender;
@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *password;
@property (copy, nonatomic) NSString *confirm;
@end
