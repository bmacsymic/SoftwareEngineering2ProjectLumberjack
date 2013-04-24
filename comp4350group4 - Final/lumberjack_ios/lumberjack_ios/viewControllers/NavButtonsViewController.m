//
//  NavButtonsViewController.m
//  LumberJack
//
//  Created by Cameron Hrycyna on 3/22/13.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "NavButtonsViewController.h"

@interface NavButtonsViewController ()

@end

@implementation NavButtonsViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)history:(id)sender {
    [self goTo:@"Workout History"];
}
- (IBAction)followers:(id)sender {
    [self goTo:@"Followers"];
}

- (IBAction)Profile:(id)sender {
    [self goTo:@"Profile"];
}

- (IBAction)newsfeed:(id)sender {
    [self goTo:@"News Feeds"];
}

- (IBAction)measurement:(id)sender {
    [self goTo:@"My Measurements"];
}

- (IBAction)workout:(id)sender {
    [self goTo:@"Workouts"];
}

-(void)goTo:(NSString *) page {
    UIViewController *newTopController = [self.storyboard instantiateViewControllerWithIdentifier:page];
    CGRect frame = self.slidingViewController.topViewController.view.frame;
    self.slidingViewController.topViewController = newTopController;
    self.slidingViewController.topViewController.view.frame = frame;
    [self.slidingViewController resetTopView];
}
@end
