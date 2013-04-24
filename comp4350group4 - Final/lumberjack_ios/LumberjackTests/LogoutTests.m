//
//  LogoutTests.m
//  LumberJack
//
//  Created by Shashank Chaudhary on 2013-03-23.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "LogoutTests.h"
#import "User.h"
#import "Session.h"
#import "SettingsViewController.h"
#import "LoginViewController.h"

@implementation LogoutTests

- (void) testValidLogout
{
    [self login];
    [[[SettingsViewController alloc ] init ] logout:self];
    User * loggedIn = [[Session getSession] loggedIn];
    STAssertTrue(loggedIn == nil, @"We expected YES, but it was NO");
}

- (void) login
{
    LoginViewController * controller = [[LoginViewController alloc] init];
    UITextField * username = [[UITextField alloc] init];
    username.text = @"Shaw";
    UITextField * password = [[UITextField alloc] init];
    password.text = @"123";
    [controller setTxtUsername:username];
    [controller setTxtPassword:password];
    [controller login:self];
}

@end
