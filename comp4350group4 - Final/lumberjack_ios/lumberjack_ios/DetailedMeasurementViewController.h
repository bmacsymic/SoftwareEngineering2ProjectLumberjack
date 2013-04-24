//
//  DetailedMeasurementViewController.h
//  LumberJack
//
//  Created by Shashank Chaudhary on 2013-03-17.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailedMeasurementViewController : UIViewController
@property (strong, nonatomic) NSMutableArray* tableData;
@property (weak, nonatomic) IBOutlet UITableView *tblDetailedMeasurements;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (copy, atomic) NSString * type;
- (IBAction)back:(id)sender;

@end
