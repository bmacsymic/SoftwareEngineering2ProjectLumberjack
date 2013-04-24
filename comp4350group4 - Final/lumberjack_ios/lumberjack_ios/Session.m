//
//  Session.m
//  LumberJack
//
//  Created by Shashank Chaudhary on 2013-03-12.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "Session.h"
#import "User.h"

@implementation Session
static Session* _session = nil;

+ (Session *) getSession
{
    if (!_session) {
        _session =[[self alloc] init];
    }
    return _session;
}

+ (void) clearSession
{
    _session = nil;
}

- (void) login: (User*) user
{
    _loggedIn = user;
}

- (void) logout
{
    _loggedIn = nil;
}

- (User*) user
{
    return _loggedIn;
}

@end
