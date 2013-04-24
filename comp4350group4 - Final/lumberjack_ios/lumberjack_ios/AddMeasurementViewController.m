//
//  AddMeasurementViewController.m
//  LumberJack
//
//  Created by Shashank Chaudhary on 2013-03-15.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "AddMeasurementViewController.h"
#import "Session.h"
#import "User.h"
#import "ServerRequests.h"
#import "DialogBox.h"
#import "Utility.h"
@interface AddMeasurementViewController ()

@end

@implementation AddMeasurementViewController

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
    [self.btnAdd setBackgroundImage:stretchable forState:UIControlStateNormal];
    [self.btnCancel setBackgroundImage:stretchable forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addMeasurement:(id)sender
{
    NSString * type = self.txtMeasurementType.text;
    NSString * unit = self.txtUnit.text;
    NSString * value = self.txtValue.text;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy HH:mm"];
    NSString *date = [dateFormat stringFromDate:self.dtmMeasurementTime.date];

    if ([self validateFields])
    {
        NSDictionary * measurement = [[ NSDictionary alloc ] initWithObjectsAndKeys:type, @"measurement_type",
                                      unit, @"measurement_unit",
                                      value, @"measurement_value",
                                      date, @"measurement_date", nil];
        User * loggedIn = [[Session getSession ] loggedIn];
        NSError * error;
        NSString * url_suffix = [[NSString alloc ] initWithFormat:@"%@/%@/%@", @"user", loggedIn.getUsername, @"new_measurement"];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:measurement options:kNilOptions error:&error];
        ASIHTTPRequest * request = [ServerRequests serverJSONPost:url_suffix json:jsonData];
        if(![request error])
        {
            NSLog(@"%@\n",[request responseString]);
            NSData * responseData = [request responseData];
            NSDictionary * json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
            if([json objectForKey:@"error"] == nil)
            {
                [DialogBox alertTitle:@"Success" alertMessage:@"Added new measurement."];
                [self dismiss];
            }
            else
            {
                [DialogBox alertTitle:@"Error" alertMessage:[json objectForKey:@"error"]];
            }
        }
        else
        {
            NSLog(@"Error : %@",[error domain]);
            [DialogBox alertTitle: @"Error" alertMessage: @"There was an error in sending your request to the server"];
        }
    }
    
}


- (IBAction)cancel:(id)sender
{
    [self dismiss];
}

- (BOOL) validateFields
{
    NSString * type = [Utility trim:self.txtMeasurementType.text];
    NSString * unit = [Utility trim:self.txtUnit.text];
    NSString * value = [Utility trim:self.txtValue.text];
    
    if ([type isEqualToString:@""]) {
        [DialogBox alertTitle:@"Error" alertMessage:@"Measurement Type cannot be empty"];
        return NO;
    }
    if ([unit isEqualToString:@""]) {
        [DialogBox alertTitle:@"Error" alertMessage:@"Unit cannot be empty"];
        return NO;
    }
    if ([value isEqualToString:@""]) {
        [DialogBox alertTitle:@"Error" alertMessage:@"Value cannot be empty"];
        return NO;
    }
    if(![Utility isNumber:value]) {
        [DialogBox alertTitle:@"Error" alertMessage:@"Value has to be numeric"];
        return NO;
    }
    return YES;
    
}

- (void) dismiss
{
    if (![self.presentedViewController isBeingDismissed]) {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
}
@end
