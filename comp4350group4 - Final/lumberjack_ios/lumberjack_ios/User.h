//
//  User.h
//  LumberJack
//
//  Created by Lianfeng Luo on 2013-03-10.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
    int userid;
    NSString *firstName;
    NSString *lastName;
    NSString *location;
    NSString *birthDate;
    NSString *avatar;
    NSString *email;
    NSString *gender;
    NSString *about;
    NSString *username;
    NSString * rDate;
    NSString * myAge;
}

-(id)init;
-(id) initWithDict: (NSDictionary*)userDict;
-(void)setUserId:(int)uid;
-(int)getUserId;
-(void)setFirstName:(NSString *) fName;
-(NSString*)getFirstName;
-(void)setLastName:(NSString *) lName;
-(NSString*)getLastName;
-(void)setLocation:(NSString *) loc;
-(NSString*)getLocation;
-(void)setAvatar:(NSString *) avat;
-(NSString*)getAvatar;
-(void)setEmail:(NSString *) em;
-(NSString*)getEmail;
-(void)setGender:(NSString *) g;
-(NSString*)getGender;
-(void)setAbout:(NSString *) ab;
-(NSString*)getAbout;
-(void)setBirthDate:(NSString *) date;
-(NSString*)getBirthDate;
-(void) setUsername:(NSString *) username;
-(NSString *)getUsername;
-(void)setRegistrationDate:(NSString *) date;
-(NSString *)getRegistrationDate;
-(NSString *)getAge;
-(void) setAge:(NSString *) age;
@end
