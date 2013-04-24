//
//  lumberjack_iosRegistrationViewController.m
//  LumberJack
//
//  Created by Shashank Chaudhary on 2013-03-09.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "RegistrationViewController.h"
#import "ASIHTTPRequest.h"
#import "ServerRequests.h"
#import "DialogBox.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController
@synthesize username = _username;
@synthesize password = _password;
@synthesize confirm = _confirm;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIImage *blackButtonImage = [UIImage imageNamed:@"blackButton.png"];
    UIImage *stretchable = [blackButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [self.btnRegister setBackgroundImage:stretchable forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)postToServer: (NSData *) json
{
    ASIHTTPRequest * request = [ServerRequests serverJSONPost:@"users/new" json:json];
    NSError * error = [request error];
    [self resetTextFields];
    [self resetErrorLabels];
    if(!error)
    {
    
        NSData * responseData = [request responseData];
        NSDictionary * json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        if([json objectForKey:@"errors"] == nil)
        {
            [DialogBox alertTitle:@"Success" alertMessage:@"Congratulations! You are now registered!"];
            [self.navigationController popViewControllerAnimated:YES];
            return YES;
        }
        else
        {
            NSString * errorKey;
            NSDictionary * errorDescriptions = [json objectForKey:@"errors"];
            for(errorKey in errorDescriptions)
            {
                NSString * errorMessage = [errorDescriptions objectForKey:errorKey][0];
                if([errorKey isEqualToString:@"username"])
                {
                    [self highlightTextBox:self.txtUsername color:[UIColor redColor]];
                    self.lblUsernameError.text = errorMessage;
                }
                else if ([errorKey isEqualToString:@"password"])
                {
                    [self highlightTextBox:self.txtPassword color:[UIColor redColor]];
                    self.lblPasswordError.text = errorMessage;
                }
                else if ([errorKey isEqualToString:@"confirm"])
                {
                    [self highlightTextBox:self.txtConfirm color:[UIColor redColor]];
                    self.lblConfirmError.text = errorMessage;
                }
                NSLog(@"%@\n", [errorDescriptions objectForKey:errorKey]);
            }
            [DialogBox alertTitle:@"Error" alertMessage:@"Error in registration information!"];
            return NO;
        }
    }
    else
    {
        [DialogBox alertTitle: @"Error" alertMessage: @"There was an error in sending your request to the server"];
        [self highlightTextBox:self.txtUsername color:[UIColor redColor]];
        return NO;
    }
        
}
- (BOOL) signUpAction:(id)sender
{
    self.username = self.txtUsername.text;
    self.password = self.txtPassword.text;
    self.confirm = self.txtConfirm.text;
    
    NSError *error;
    NSDictionary *signup = [[NSDictionary alloc] initWithObjectsAndKeys: self.username, @"username",
                            self.password, @"password", self.confirm, @"confirm", nil];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:signup options:NSJSONWritingPrettyPrinted error:&error];
    return [self postToServer:jsonData];
}

- (IBAction)signUp:(id)sender
{
    [self signUpAction:sender];
}

- (void) highlightTextBox: (UITextField *) textField color: (UIColor *) color
{
    textField.layer.cornerRadius=8.0f;
    textField.layer.masksToBounds=YES;
    textField.layer.borderColor=[color CGColor];
    textField.layer.borderWidth= 3.0f;
}

- (void) resetTextFields
{
    for (UIView *view in [self.view subviews])
    {
        if ([view isKindOfClass:[UITextField class]])
        {
            UITextField * curr = (UITextField *) view;
            [self highlightTextBox: curr color:[UIColor greenColor]];
        }
    }
}

- (void) resetErrorLabels
{
    self.lblUsernameError.text = @"";
    self.lblPasswordError.text = @"";
    self.lblConfirmError.text  = @"";
}

- (IBAction) confirmChanged
{
    NSString * password = self.txtPassword.text;
    NSString * confirm = self.txtConfirm.text;
    if ([password isEqualToString: confirm]) {
        self.lblPasswordError.text = @"";
        self.lblConfirmError.text  = @"";
        [self highlightTextBox:self.txtPassword color:[UIColor greenColor]];
        [self highlightTextBox:self.txtConfirm color:[UIColor greenColor]];
    }
    else
    {
        NSString * error = @"Passwords donot match";
        [self highlightTextBox:self.txtPassword color:[UIColor redColor]];
        [self highlightTextBox:self.txtConfirm color:[UIColor redColor]];
        self.lblPasswordError.text = error;
        self.lblConfirmError.text  = error;
    }
}
@end
