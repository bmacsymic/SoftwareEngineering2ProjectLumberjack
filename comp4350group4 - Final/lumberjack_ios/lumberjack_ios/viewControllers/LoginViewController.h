//
//  LoginControllerViewController.h
//  LumberJack
//
//  Created by Shashank Chaudhary on 2013-03-12.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogIn;
- (IBAction)login:(id)sender;

@end
