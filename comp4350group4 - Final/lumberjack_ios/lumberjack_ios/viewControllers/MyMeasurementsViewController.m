//
//  MyMeasurementsViewController.m
//  LumberJack
//
//  Created by Cameron Hrycyna on 2013-03-14.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "MyMeasurementsViewController.h"
#import "ECSlidingViewController.h"
#import "MeMenuViewController.h"
#import "User.h"
#import "Session.h"
#import "ServerRequests.h"
#import "DetailedMeasurementViewController.h"
@interface MyMeasurementsViewController ()

@end

@implementation MyMeasurementsViewController

NSMutableArray *tableData;
NSString * selectedType;
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
  //  [self.tblLatestMeasurements setEditing:YES animated:YES];
    [self addGesture];
    UIImage *blackButtonImage = [UIImage imageNamed:@"blackButton.png"];
    UIImage *stretchable = [blackButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [self.btnAdd setBackgroundImage:stretchable forState:UIControlStateNormal];
	// Do any additional setup after loading the view.

}

- (void) viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    NSLog(@"%@", @"Helooo 121312312312");
    [self getMeasurmentSummary];
    [self.tblLatestMeasurements reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    MeasurementTableCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MeasurementTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    NSDictionary* measurement = [tableData objectAtIndex:indexPath.row ];
    cell.lblMeasurementType.text = [measurement objectForKey:@"type"];
    NSString * value = [[measurement objectForKey:@"value"] stringValue];
    NSString * unit = [measurement objectForKey:@"unit"];
    NSString * valueWithUnit = [[NSString alloc] initWithFormat:@"%@ %@", value, unit];
    cell.lblMeasurementValue.text = valueWithUnit;
    cell.lblMeasurementTime.text = [measurement objectForKey:@"date"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView ]
    MeasurementTableCell *cell = (MeasurementTableCell *) [tableView cellForRowAtIndexPath:indexPath];
    selectedType = cell.lblMeasurementType.text;
    [self performSegueWithIdentifier:@"goToDetailedMeasurements" sender:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (void)getMeasurmentSummary
{    User *luser = [[Session getSession] loggedIn];
    
    NSString *url = [NSString stringWithFormat:@"%@%@/measurement_summary", @"user/", luser.getUsername];
    
    NSDictionary *dictionary = [ServerRequests serverGetRequest:url data:nil];
    
    if (dictionary) {
        tableData = [NSMutableArray array];
        NSArray * measurements = [dictionary objectForKey:@"measurements"];
        for (NSDictionary* measurement in measurements)
        {
            [tableData addObject:measurement];
        }
    }
    
    NSLog(@"%d", [tableData count]);
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"goToDetailedMeasurements"]) {
        DetailedMeasurementViewController * secondController = [segue destinationViewController];
        secondController.type = selectedType;
    }
}

@end
