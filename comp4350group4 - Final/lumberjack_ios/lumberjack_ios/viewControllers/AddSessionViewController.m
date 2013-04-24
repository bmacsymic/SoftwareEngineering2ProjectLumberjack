//
//  AddSessionViewController.m
//  LumberJack
//
//  Created by Cameron Hrycyna on 3/9/13.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "AddSessionViewController.h"
#import "ServerRequests.h"
#import "DialogBox.h"
#import "Session.h"
#import "User.h"

@interface AddSessionViewController ()
@end

@implementation AddSessionViewController

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
    [self.btnAddSession setBackgroundImage:stretchable forState:UIControlStateNormal];
    [self.btnCancel setBackgroundImage:stretchable forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addSession:(id)sender
{
    User * current = [[Session getSession] user];
    
    if(current == nil)
    {
        NSLog(@"ERROR - Not Logged In");
    }
    else
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
        NSString *dateString = [dateFormat stringFromDate:_session_date.date];
        
        if([self validateFields])
        {
            NSDictionary *request = [[NSDictionary alloc] initWithObjectsAndKeys:_workout_name.text, @"wName", dateString, @"date", _session_comments.text, @"desc",[current getUsername], @"user",nil];
            NSDictionary * result = [ServerRequests serverFormPost:@"submit_workout_history" data:request];
            if (result != nil && [[result objectForKey:@"result"] isEqual: @"success"])
            {
                if (![self.presentedViewController isBeingDismissed]) {
                    [self dismissViewControllerAnimated:YES completion:^{}];
                }
            }
            else
            {
                [DialogBox alertTitle:@"Whoopsy" alertMessage:[result objectForKey:@"content"]];
            }
        }
    }
}

- (IBAction)cancel:(id)sender
{
    if (![self.presentedViewController isBeingDismissed]) {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
}

- (BOOL) validateFields
{
    if([_workout_name.text isEqualToString:@""])
    {
        [DialogBox alertTitle: @"No Workout Name" alertMessage: @"Please enter a workout name"];
        return NO;
    }
    if([_session_comments.text isEqualToString:@""])
    {
        [DialogBox alertTitle: @"No Comments" alertMessage: @"Please enter some session comments :D"];
        return NO;
    }
    return YES;
}
@end
