//
//  FollowersViewControllerTests.m
//  LumberJack
//
//  Created by Jeremy Randy Turcotte on 2013-03-19.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "FollowersViewControllerTests.h"
#import "FollowersViewController.h"
#import "SettingsViewController.h"
#import "LoginViewControllerTest.h"
#import "Session.h"
#import "User.h"

@interface FollowersViewControllerTests ()

@end

@implementation FollowersViewControllerTests


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

//used from shaw's loginviewcontroller testing case
- (void) testValidLogin
{
    LoginViewController * controller = [[LoginViewController alloc] init];
    UITextField * username = [[UITextField alloc] init];
    username.text = @"Jeremy";
    UITextField * password = [[UITextField alloc] init];
    password.text = @"123";
    [controller setTxtUsername:username];
    [controller setTxtPassword:password];
    [controller login:self];
    User * loggedIn = [[Session getSession] loggedIn];
    STAssertTrue(loggedIn != nil, @"We expected YES, but it was NO");
    STAssertTrue([[loggedIn getUsername] isEqualToString:@"Jeremy"], @"We expected YES, but it was NO");
}

- (void) testValidFollowersTable
{    
    NSMutableArray* followersTableData = [[NSMutableArray alloc] init];
    NSObject *u1 = [[NSObject alloc] init] ;
    NSObject *u2 = [[NSObject alloc] init] ;
    NSObject *u3 = [[NSObject alloc] init] ;
    
    u1 = @"Zapp" ;
    [followersTableData addObject: u1];
    u2 = @"Shaw" ;
    [followersTableData addObject: u2];
    u3 = @"Cameron" ;
    [followersTableData addObject: u3];
    
    STAssertTrue([followersTableData count] == 3, @"We expect YES, but it was NO") ;
    STAssertEquals(u1, [followersTableData objectAtIndex:(0)], @"Zapp") ;
    STAssertEquals(u2, [followersTableData objectAtIndex:(1)], @"Shaw") ;
    STAssertEquals(u3, [followersTableData objectAtIndex:(2)], @"Cameron") ;
}
@end