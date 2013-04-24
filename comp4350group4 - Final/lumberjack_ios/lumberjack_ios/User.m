//
//  User.m
//  LumberJack
//
//  Created by Lianfeng Luo on 2013-03-10.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "User.h"

@implementation User

- (id)init
{
    if (self = [super init]) {
        firstName = nil;
        lastName = nil;
    }
    return self;
}

- (id)init:(NSString *)fName andLastName:(NSString *)lName {
    if (self = [super init]) {
        firstName = fName;
        lastName = lName;
    }
    return self;
}

- (id) initWithDict: userDict
{
    if (self = [super init])
    {
        username = userDict[@"username"];
        firstName = userDict[@"firstname"];
        lastName = userDict[@"lastname"];
        location = userDict[@"location"];
        birthDate = userDict[@"birth"];
        avatar  = userDict[@"avatar"];
        email = userDict[@"email"];
        gender = userDict[@"sex"];
        about = userDict[@"about_me"];
        userid = [ userDict[@"id"] intValue ];
    }
    return self;
}
- (int) getUserId {
    return userid;
}

- (void) setUserId:(int)uid {
    userid = uid;
}

- (void) setRegistrationDate:(NSString*)date {
    rDate = date;
}
- (NSString *) getRegistrationDate {
    return rDate;
}


- (NSString *) getFirstName {
    return firstName;
}

- (void) setFirstName:(NSString *)fName {
    firstName = fName;
}

- (NSString *) getLastName {
    return lastName;
}

- (void) setLastName:(NSString *)lName {
    lastName = lName;
}

- (NSString *) getLocation {
    return location;
}

- (void) setLocation:(NSString *)loc {
    location = loc;
}

- (NSString *) getAvatar {
    return avatar;
}

- (void) setAvatar:(NSString *)avat {
    avatar = avat;
}

- (NSString *) getEmail {
    return email;
}

- (void) setEmail:(NSString *)em {
    email = em;
}

- (NSString *) getGender {
    return gender;
}

- (void) setGender:(NSString *)g {
    gender = g;
}

- (NSString *) getAbout {
    return about;
}

- (void) setAbout:(NSString *)ab {
    about = ab;
}

- (NSString *) getBirthDate {
    return birthDate;
}

- (void) setBirthDate:(NSString *) date {
    birthDate = date;
}

- (NSString *) getUsername {
    return username;
}
-(NSString *) getAge
{
    return myAge;
}
-(void) setAge:(NSString *)age {
    myAge = age;
}

-(void) setUsername:(NSString *)user {
    username = user;
}
@end
