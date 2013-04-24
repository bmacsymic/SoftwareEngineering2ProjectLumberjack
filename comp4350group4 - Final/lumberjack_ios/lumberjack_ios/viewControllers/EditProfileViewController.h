//
//  EditProfileViewController.h
//  LumberJack
//
//  Created by Lianfeng Luo on 2013-03-10.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface EditProfileViewController : UIViewController
@property(nonatomic, retain) User *user;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *locationField;
@property (weak, nonatomic) IBOutlet UITextField *avatarField;
@property (weak, nonatomic) IBOutlet UITextField *birthDateField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderOption;
@property (weak, nonatomic) IBOutlet UITextView *aboutField;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
- (IBAction)saveBtn:(id)sender;
- (IBAction)cancelBtn:(id)sender;
- (BOOL)isValidInput;

@end
