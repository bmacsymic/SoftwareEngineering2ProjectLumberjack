//
//  DetailedMeasurementViewController.m
//  LumberJack
//
//  Created by Shashank Chaudhary on 2013-03-17.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "DetailedMeasurementViewController.h"
#import "Session.h"
#import "User.h"
#import "ServerRequests.h"
#import "MeasurementTableCell.h"
@interface DetailedMeasurementViewController ()

@end

@implementation DetailedMeasurementViewController
@synthesize type;
NSMutableArray *tableData;

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
    tableData = [NSMutableArray array];
    NSLog(@"Recieved: %@", type);
    
    UIImage *blackButtonImage = [UIImage imageNamed:@"blackButton.png"];
    UIImage *stretchable = [blackButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [self.btnBack setBackgroundImage:stretchable forState:UIControlStateNormal];
    
	// Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated
{
    [self getMeasurments];
    [self.tblDetailedMeasurements reloadData];
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
- (void)getMeasurments
{
    User *luser = [[Session getSession] loggedIn];
    NSString *url = [NSString stringWithFormat:@"user/%@/measurement/%@", luser.getUsername, type];
    NSString *encodedUrl = [url stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
    NSDictionary * dictionary = [ServerRequests serverGetRequest:encodedUrl data:nil];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}
- (IBAction)back:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}
@end
