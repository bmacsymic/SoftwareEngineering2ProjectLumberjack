//
//  RegistrationViewControllerTests.m
//  LumberJack
//
//  Created by Shashank Chaudhary on 2013-03-23.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "RegistrationViewControllerTests.h"
#import "RegistrationViewController.h"
@implementation RegistrationViewControllerTests

- (BOOL)username: (NSString*)username
        password: (NSString*) password
         confirm: (NSString*) confirm
{
    RegistrationViewController * controller = [[RegistrationViewController alloc] init];
    UITextField * usernameField = [[UITextField alloc] init];
    usernameField.text = username;
    UITextField * passwordField = [[UITextField alloc] init];
    passwordField.text = password;
    UITextField * confirmField = [[UITextField alloc] init];
    confirmField.text = confirm;
    
    [controller setTxtUsername:usernameField];
    [controller setTxtPassword:passwordField];
    [controller setTxtConfirm:confirmField];
    return [controller signUpAction:self];
}

- (NSString *) uniqueishUsername
{
    double timestamp =[[NSDate date] timeIntervalSince1970];
    NSString * user =  [[NSString alloc] initWithFormat:@"%@%f", @"octestUser", timestamp];
    NSLog(@"%@\n", user);
    return user;
}

- (void) testValidUserRegistration
{
    NSString * user = [self uniqueishUsername];
    BOOL userCreated = [self username:user password:@"123" confirm:@"123"];
    STAssertTrue(userCreated, @"We expected YES, but it was NO");
}

- (void) testExistingUserRegistration
{
    //create a user just to be sure
    [self username:@"octestUser" password:@"123" confirm:@"123"];
    //actual test
    BOOL userCreated = [self username:@"octestUser" password:@"123" confirm:@"123"];
    STAssertFalse(userCreated, @"We expected NO, but it was YES");
}

- (void) testPasswordDoesNotMatchWithConfirm
{
    NSString * user = [self uniqueishUsername];
    BOOL userCreated = [self username:user password:@"123" confirm:@"12312"];
    STAssertFalse(userCreated, @"We expected NO, but it was YES");
}

- (void) testMissingUsername
{
    NSString * user = @"";
    BOOL userCreated = [self username:user password:@"123" confirm:@"123"];
    STAssertFalse(userCreated, @"We expected NO, but it was YES");
}

- (void) testMissingPassword
{
    NSString * user = [self uniqueishUsername];
    BOOL userCreated = [self username:user password:@"" confirm:@"123"];
    STAssertFalse(userCreated, @"We expected NO, but it was YES");
}

- (void) testMissingConfirm
{
    NSString * user = [self uniqueishUsername];
    BOOL userCreated = [self username:user password:@"123" confirm:@""];
    STAssertFalse(userCreated, @"We expected NO, but it was YES");
}

- (void) testMissingUsernamePasswordAndConfirm
{
    NSString * user = @"";
    BOOL userCreated = [self username:user password:@"" confirm:@""];
    STAssertFalse(userCreated, @"We expected NO, but it was YES");
}

@end
