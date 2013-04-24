//
//  ProfileViewController.h
//  LumberJack
//
//  Created by Lianfeng Luo on 2013-03-09.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditProfileViewController.h"
#import "User.h"

User *user;

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UITextView *userName;
@property (weak, nonatomic) IBOutlet UITextView *gender;
@property (weak, nonatomic) IBOutlet UITextView *age;
@property (weak, nonatomic) IBOutlet UITextView *registration;
@property (weak, nonatomic) IBOutlet UITextView *location;
@property (weak, nonatomic) IBOutlet UITextView *about;
@property (weak, nonatomic) IBOutlet UIButton *btnEditProfile;
- (IBAction)menuOpen:(id)sender;
- (BOOL) isNullOrEmptyValue:(NSString *) val;
-(User *) parseUser: (NSDictionary *) dict;

- (IBAction)goToNav:(id)sender;

@end
