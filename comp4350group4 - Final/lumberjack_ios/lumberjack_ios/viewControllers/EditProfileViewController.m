//
//  EditProfileViewController.m
//  LumberJack
//
//  Created by Lianfeng Luo on 2013-03-10.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "EditProfileViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "DialogBox.h"
#import "ServerRequests.h"
#import <QuartzCore/QuartzCore.h>

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController
@synthesize user;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dismissKeyboard {
    [_firstNameField resignFirstResponder];
    [_lastNameField resignFirstResponder];
    [_emailField resignFirstResponder];
    [_locationField resignFirstResponder];
    [_birthDateField resignFirstResponder];
    [_avatarField resignFirstResponder];
    [_aboutField resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *blackButtonImage = [UIImage imageNamed:@"blackButton.png"];
    UIImage *stretchable = [blackButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [self.btnSave setBackgroundImage:stretchable forState:UIControlStateNormal];
    [self.btnCancel setBackgroundImage:stretchable forState:UIControlStateNormal];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
        
    NSLog(@"%@", user.getFirstName);
    [[self.aboutField layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.aboutField layer] setBorderWidth:2.3];
    [[self.aboutField layer] setCornerRadius:15];
    
    _firstNameField.text = user.getFirstName;
    _lastNameField.text = user.getLastName;
    _locationField.text = user.getLocation;
    _emailField.text = user.getEmail;
    _aboutField.text = user.getAbout;
    _birthDateField.text = user.getBirthDate;
    _avatarField.text = user.getAvatar;
    if ([user.getGender isEqualToString:@"M"]) {
        _genderOption.selectedSegmentIndex = 0;
    } else if ([user.getGender isEqualToString:@"F"]) {
        _genderOption.selectedSegmentIndex = 1;
    } else {
        _genderOption.selectedSegmentIndex = 2;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveBtn:(id)sender {
    if (self.isValidInput) {
        NSString *gender = nil;
        if (_genderOption.selectedSegmentIndex == 0) {
            gender = @"M";
        } else if (_genderOption.selectedSegmentIndex == 1) {
            gender = @"F";
        } else {
            gender = @"X";
        }
    
        NSDictionary *update = [[NSDictionary alloc] initWithObjectsAndKeys: [NSString stringWithFormat:@"%d",user.getUserId], @"uid", _firstNameField.text, @"firstname", _lastNameField.text, @"lastname", _locationField.text, @"location", _emailField.text, @"email", _avatarField.text, @"gravatar", _aboutField.text, @"about-me", _birthDateField.text, @"date_of_birth", gender, @"gender", nil];
    
        NSDictionary *response = [ServerRequests serverFormPost:@"user/update-profile/" data:update];
        if (response == nil) {
            [DialogBox alertTitle:@"Error" alertMessage:@"Error Communicating with the server."];
        } else if ([[response objectForKey:@"result"] hasPrefix:@"Email"]) {
            [DialogBox alertTitle:@"Email Conflict" alertMessage:@"Our record shows that you have an account under the given email address already."];
        } else if (![[response objectForKey:@"result"] isEqual:@"OK"]) {
            [DialogBox alertTitle:@"Update Error" alertMessage:@"There was an error in sending your updates to the server"];
        }else {
            [DialogBox alertTitle:@"Success" alertMessage:@"Your changes have been made."];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (IBAction)cancelBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)isValidInput
{
    if ([_firstNameField.text length] == 0) {
        [DialogBox alertTitle:@"First name" alertMessage:@"First name field cannot be empty"];
        return NO;
    }
    if ([_lastNameField.text length] == 0) {
        [DialogBox alertTitle:@"Last name" alertMessage:@"Last name field cannot be empty"];
        return NO;
    }
    if ([_emailField.text length] == 0) {
        [DialogBox alertTitle:@"Email" alertMessage:@"Email field cannot be empty"];
        return NO;
    }
    if ([_aboutField.text length] > 140) {
        [DialogBox alertTitle:@"About Me" alertMessage:[NSString stringWithFormat:@"Your about me field is %d chars long, %@", [_aboutField.text length], @"Max allowed is 140 characters"]];
        return NO;
    }
    
    return YES;
}



@end
