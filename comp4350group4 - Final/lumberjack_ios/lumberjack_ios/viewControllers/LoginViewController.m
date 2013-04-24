//
//  LoginControllerViewController.m
//  LumberJack
//
//  Created by Shashank Chaudhary on 2013-03-12.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "LoginViewController.h"
#import "ASIHTTPRequest.h"
#import "ServerRequests.h"
#import "DialogBox.h"
#import "User.h"
#import "Session.h"
#import "EditProfileViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

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
    
    NSLog(@"Login ViewDidLoad");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //something here
    User *luser = [[Session getSession] loggedIn];
    
    if (luser)
    {
        self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:3];
    }
    NSLog(@"Login ViewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //something here
    User *luser = [[Session getSession] loggedIn];
    
    if (luser)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    NSLog(@"Login ViewDidAppear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender
{
    NSString * username = self.txtUsername.text;
    NSString * password = self.txtPassword.text;
    
    NSDictionary * info = [ [NSDictionary alloc] initWithObjectsAndKeys:username, @"username", password, @"password", nil ];
    NSDictionary * response = [ServerRequests serverFormPost:@"login" data: info];
    if (response == nil)
    {
        [DialogBox alertTitle:@"Error" alertMessage:@"Error Communicating with the server"];
    }
    else if ([response objectForKey:@"errors"])
    {
        [DialogBox alertTitle:@"Login Error" alertMessage:@"Unable to Log In! Verify login information"];
    }
    else
    {
        User * user = [[User alloc] initWithDict:response];
        [ [Session getSession] login: user];
        NSLog(@"%s: %@ (%d)\n", "Logged In: ", user.getUsername, user.getUserId);
        self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
    }
}
@end
