//
//  InitMeController.m
//  LumberJack
//
//  Created by Cameron Hrycyna on 2013-03-14.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "InitMeController.h"
#import "MeMenuViewController.h"
#import "User.h"
#import "Session.h"

@interface InitMeController ()

@end


@implementation InitMeController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) addGesture
{
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MeMenuViewController class]])
    {
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addGesture];
    NSLog(@"InitMe ViewDidLoad");
	//self.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Profile"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //something here
    User *luser = [[Session getSession] loggedIn];
    
    if (luser)
    {
        self.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Profile"];
    } else {
        self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:3];
    }

    NSLog(@"InitMe ViewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //something here
    User *luser = [[Session getSession] loggedIn];
    
    if (luser)
    {
        self.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Profile"];
    } else {
        self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:3];
    }
    NSLog(@"InitMe ViewDidAppear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)openMenu:(id)sender {
    printf("open menu init");
}
@end
