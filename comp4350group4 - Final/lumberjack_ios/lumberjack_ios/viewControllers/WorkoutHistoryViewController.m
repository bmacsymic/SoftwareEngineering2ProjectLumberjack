//
//  WorkoutHistoryViewController.m
//  LumberJack
//
//  Created by Cameron Hrycyna on 3/10/13.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "WorkoutHistoryViewController.h"
#import "ProfileViewController.h"
#import "ServerRequests.h"
#import "ECSlidingViewController.h"
#import "MeMenuViewController.h"
#import "Session.h"
#import "User.h"
#import "DialogBox.h"

@interface WorkoutHistoryViewController ()

@property (weak, nonatomic) IBOutlet UITableView *session_table;
@property (weak, nonatomic) IBOutlet UITextView *workout_name;
@property (weak, nonatomic) IBOutlet UITextView *session_date;
@property (weak, nonatomic) IBOutlet UITextView *session_comments;

@end

@implementation WorkoutHistoryViewController

NSMutableArray *tableData;
NSArray * workouts;

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
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addGesture];
    
    User * current = [[Session getSession] user];
    
    if(current == nil)
    {
        //Redirect to Profile Page if not logged in
        [DialogBox alertTitle:@"Not Logged In" alertMessage:@"Please Log in to view your workout history"];
        
        //Redirect to Profile Page if not logged in
        UIViewController *newTopController = [self.storyboard instantiateViewControllerWithIdentifier:@"Profile"];
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }
    else
    {
        NSDictionary *request = [[NSDictionary alloc] initWithObjectsAndKeys: [current getUsername], @"name", nil];
        NSDictionary * result = [ServerRequests serverGetRequest:@"workouts/getWorkoutHistory" data:request];
        if (result != nil && [[result objectForKey:@"Result"] isEqual: @"OK"])
        {
            workouts = [result objectForKey:@"Contents"];
            tableData = [NSMutableArray array]; //create a brand new array
            for (id workout in workouts)
            {
                
                NSString * name = [workout objectForKey:@"name"];
                
                [tableData addObject:name];
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id workout = [workouts objectAtIndex:[indexPath item]];
    _workout_name.text = [workout objectForKey:@"name"];
    _session_date.text = [workout objectForKey:@"date"];
    _session_comments.text = [workout objectForKey:@"comments"];
}
- (IBAction)menuOpen:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)goToNav:(id)sender {
    UIViewController *newTopController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavButtons"];
    CGRect frame = self.slidingViewController.topViewController.view.frame;
    self.slidingViewController.topViewController = newTopController;
    self.slidingViewController.topViewController.view.frame = frame;
    [self.slidingViewController resetTopView];
}
@end
