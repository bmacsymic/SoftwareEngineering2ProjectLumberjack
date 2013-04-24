//
//  SettingsViewController.m
//  LumberJack
//
//  Created by Shashank Chaudhary on 2013-03-12.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "SettingsViewController.h"
#import "Session.h"
#import "User.h"
#import "ServerRequests.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
    [self.btnLogIn setBackgroundImage:stretchable forState:UIControlStateNormal];
    [self.btnLogOut setBackgroundImage:stretchable forState:UIControlStateNormal];
    [self.btnRegister setBackgroundImage:stretchable forState:UIControlStateNormal];
    NSLog(@"SettingsView ViewDidLoad");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //something here
    
    NSLog(@"SettingsView ViewWillAppear");
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    User * loggedIn = [[Session getSession] loggedIn];
    if(!loggedIn)
    {
        self.btnLogIn.hidden = NO;
        self.btnLogOut.hidden = YES;
    }
    else
    {
        self.btnLogOut.hidden = NO;
        self.btnLogIn.hidden = YES;
    }
    NSLog(@"SettingsView ViewDidAppear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logout:(id)sender
{
    [ServerRequests serverGetRequest:@"logout" data:nil];
    [[Session getSession] logout];
    self.btnLogIn.hidden = NO;
    self.btnLogOut.hidden = YES;
}
@end
