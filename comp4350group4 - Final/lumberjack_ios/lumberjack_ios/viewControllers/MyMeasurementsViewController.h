//
//  MyMeasurementsViewController.h
//  LumberJack
//
//  Created by Cameron Hrycyna on 2013-03-14.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeasurementTableCell.h"
@interface MyMeasurementsViewController : UIViewController
{
   // MeasurementTableCell * cell;
}
@property (strong, nonatomic) NSMutableArray* tableData;
@property (weak, nonatomic) IBOutlet UITableView *tblLatestMeasurements;
//@property (nonatomic, retain) IBOutlet MeasurementTableCell *cell;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

- (IBAction)menuOpen:(id)sender;
- (IBAction)goToNav:(id)sender;

@end
