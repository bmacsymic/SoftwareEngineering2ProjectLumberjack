//
//  HomeViewController.m
//  LumberJack
//
//  Created by Cameron Hrycyna on 2013-03-23.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "HomeViewController.h"
#import "ServerRequests.h"
#import "HomeCell.h"
#import "WorkoutViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *workouts;

@end

@implementation HomeViewController

@synthesize tableData;
@synthesize workouts;

NSString * workoutId;

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
            
    NSString *url = [NSString stringWithFormat:@"%@", @"workouts/get_most_recent"];
    
    NSDictionary *dictionary = [ServerRequests serverGetRequest:url data:nil];
    
    if (dictionary) {
        tableData = [NSMutableArray array];
        NSArray * objs = [dictionary objectForKey:@"Content"];
        for (id workout in objs)
        {            
            [tableData addObject:workout];
        }
    }
    
    NSLog(@"%d", [tableData count]);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    workoutId = [[tableData objectAtIndex:indexPath.row] objectForKey:@"id"];
    NSLog(@"%@",workoutId);
    [self performSegueWithIdentifier:@"pushWorkout" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WorkoutViewController *controller = (WorkoutViewController *) segue.destinationViewController;
    controller.workoutSearchId = workoutId;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"HomeCell";
    
    HomeCell *cell = (HomeCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.workoutName.text = [[tableData objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.workoutDescription.text = [[tableData objectAtIndex:indexPath.row] objectForKey:@"description"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
@end
