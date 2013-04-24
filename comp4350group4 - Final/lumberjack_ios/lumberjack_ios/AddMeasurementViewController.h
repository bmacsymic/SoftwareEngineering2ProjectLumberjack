//
//  AddMeasurementViewController.h
//  LumberJack
//
//  Created by Shashank Chaudhary on 2013-03-15.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMeasurementViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtMeasurementType;
@property (weak, nonatomic) IBOutlet UITextField *txtUnit;
@property (weak, nonatomic) IBOutlet UIDatePicker *dtmMeasurementTime;
@property (weak, nonatomic) IBOutlet UITextField *txtValue;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
- (IBAction)addMeasurement:(id)sender;
- (IBAction)cancel:(id)sender;
- (BOOL) validateFields;
@end
