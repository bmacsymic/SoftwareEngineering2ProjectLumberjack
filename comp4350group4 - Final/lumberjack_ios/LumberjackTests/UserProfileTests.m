//
//  UserProfileTests.m
//  LumberJack
//
//  Created by Jeremy Randy Turcotte on 2013-03-23.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "UserProfileTests.h"
#import "SettingsViewController.h"
#import "LoginViewControllerTest.h"
#import "Session.h"
#import "User.h"
#import "UserProfile.h"

@interface UserProfileTests ()

@end

@implementation UserProfileTests

- (void) setUp
{
    [Session clearSession];
    [[[SettingsViewController alloc ] init ] logout:self];
    
    LoginViewController * controller = [[LoginViewController alloc] init];
    UITextField * username = [[UITextField alloc] init];
    username.text = @"Jeremy";
    UITextField * password = [[UITextField alloc] init];
    password.text = @"123";
    [controller setTxtUsername:username];
    [controller setTxtPassword:password];
    [controller login:self];    
}

- (void) tearDown
{
    [Session clearSession];
    [[[SettingsViewController alloc ] init ] logout:self];
}


@end