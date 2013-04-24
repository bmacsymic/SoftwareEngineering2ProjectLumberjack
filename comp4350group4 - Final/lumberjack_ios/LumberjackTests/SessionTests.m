//
//  SessionTests.m
//  LumberJack
//
//  Created by Shashank Chaudhary on 2013-03-18.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "SessionTests.h"
#import "Session.h"
#import "User.h"

@implementation SessionTests

- (void)testGetSession
{
    Session * session = [Session getSession];
    STAssertTrue((session != nil), @"We expected YES, but it was NO");
}

- (void) testDefaultSessionUser
{
    [Session clearSession];
    Session * session = [Session getSession];
    STAssertTrue(([session loggedIn] == nil), @"We expected YES, but it was NO");
}

- (void) testSessionLogin
{
    Session * session = [Session getSession];
    User * user = [[User alloc] init];
    [session login:user];
    STAssertTrue(([session loggedIn] == user), @"We expected YES, but it was NO");
}

- (void) testSessionLogout
{
    Session * session = [Session getSession];
    User * user = [[User alloc] init];
    [session login:user];
    [session logout];
    STAssertTrue(([session loggedIn] == nil), @"We expected YES, but it was NO");
}
@end
