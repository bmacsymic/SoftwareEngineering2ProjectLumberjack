//
//  ProfileViewControllerTests.m
//  LumberJack
//
//  Created by Lianfeng Luo on 2013-03-20.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "ProfileViewControllerTests.h"

@implementation ProfileViewControllerTests

ProfileViewController *view;

- (void)setUp
{
    [super setUp];
    // Set-up code here.
    view = [[ProfileViewController alloc] init];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void) testIsNullOrEmptyValuePassingEmptyValueReturnsYES
{
    BOOL result = [view isNullOrEmptyValue:@""];
    STAssertTrue(result, @"We expected YES, but it was NO");
}

- (void) testIsNullOrEmptyValuePassingNonEmptyValueReturnsNO
{
    BOOL result = [view isNullOrEmptyValue:@"lumberjack"];
    STAssertFalse(result, @"We expected NO, but it was YES");
}

- (void) testParseUserPassingEmptyDictionaryReturnsEmptyUser
{
    User *user = [view parseUser:nil];
    
    STAssertNotNil(user, @"We expected a empty user, not a nil user object");
}

@end
