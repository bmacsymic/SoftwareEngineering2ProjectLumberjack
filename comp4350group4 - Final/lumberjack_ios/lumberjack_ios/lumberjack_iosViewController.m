//
//  lumberjack_iosViewController.m
//  lumberjack_ios
//
//  Created by Kyle Andrew Pollock on 2013-03-08.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "lumberjack_iosViewController.h"
#import "ASIHTTPRequest.h"

@interface lumberjack_iosViewController ()

@end

@implementation lumberjack_iosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
/*    NSURL *url = [NSURL URLWithString:@"http://ec2-204-236-195-129.compute-1.amazonaws.com:5000/user/troll"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        NSLog(  "%@", response);
    }*/
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
