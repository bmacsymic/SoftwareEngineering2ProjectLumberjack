//
//  Session.h
//  LumberJack
//
//  Created by Shashank Chaudhary on 2013-03-12.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface Session : NSObject

@property(copy, atomic) User* loggedIn;
+ (Session *) getSession;
+ (void) clearSession;
- (void) login: (User*) user;
- (void) logout;
- (User*) user;

@end
