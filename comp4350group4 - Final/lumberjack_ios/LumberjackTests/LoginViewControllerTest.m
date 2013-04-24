//
//  LoginViewControllerTest.m
//  LumberJack
//
//  Created by Shashank Chaudhary on 2013-03-18.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "LoginViewControllerTest.h"
#import "SettingsViewController.h"
#import "Session.h"
#import "User.h"

@implementation LoginViewControllerTest

- (void) setUp
{
    [Session clearSession];
    [[[SettingsViewController alloc ] init ] logout:self];
}

- (void) tearDown
{
    [Session clearSession];
    [[[SettingsViewController alloc ] init ] logout:self];
}

- (void) testValidLogin
{
    LoginViewController * controller = [[LoginViewController alloc] init];
    UITextField * username = [[UITextField alloc] init];
    username.text = @"Shaw";
    UITextField * password = [[UITextField alloc] init];
    password.text = @"123";
    [controller setTxtUsername:username];
    [controller setTxtPassword:password];
    [controller login:self];
    User * loggedIn = [[Session getSession] loggedIn];
    STAssertTrue(loggedIn != nil, @"We expected YES, but it was NO");
    STAssertTrue([[loggedIn getUsername] isEqualToString:@"Shaw"], @"We expected YES, but it was NO");
}

- (void) testValidUserInvalidPassword
{
    LoginViewController * controller = [[LoginViewController alloc] init];
    UITextField * username = [[UITextField alloc] init];
    username.text = @"Shaw";
    UITextField * password = [[UITextField alloc] init];
    password.text = @"wrong_pass";
    [controller setTxtUsername:username];
    [controller setTxtPassword:password];
    [controller login:self];
    User * loggedIn = [[Session getSession] loggedIn];
    STAssertTrue(loggedIn == nil, @"We expected YES, but it was NO");
}

- (void) testValidPasswordInvalidUsername
{
    LoginViewController * controller = [[LoginViewController alloc] init];
    UITextField * username = [[UITextField alloc] init];
    username.text = @"Shawaaa";
    UITextField * password = [[UITextField alloc] init];
    password.text = @"123";
    [controller setTxtUsername:username];
    [controller setTxtPassword:password];
    [controller login:self];
    User * loggedIn = [[Session getSession] loggedIn];
    STAssertTrue(loggedIn == nil, @"We expected YES, but it was NO");
}
@end
