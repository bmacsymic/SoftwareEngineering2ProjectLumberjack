//
//  UserProfile.h
//  LumberJack
//
//  Created by Lianfeng Luo on 2013-03-19.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface UserProfile : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *username;
@property (weak, nonatomic) IBOutlet UIImageView *avatarVIew;
@property (weak, nonatomic) IBOutlet UITextView *gender;
@property (weak, nonatomic) IBOutlet UITextView *age;
@property (weak, nonatomic) IBOutlet UITextView *registrationDate;
@property (weak, nonatomic) IBOutlet UITextView *location;
@property (weak, nonatomic) IBOutlet UITextView *about;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;

@property(nonatomic, retain) User *user;

extern BOOL follow_state ;

- (IBAction)followBTN_action:(id)sender;


@end
