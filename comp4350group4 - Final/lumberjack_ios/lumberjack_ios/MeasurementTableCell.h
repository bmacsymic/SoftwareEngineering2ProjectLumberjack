//
//  lumberjack_iosCell.h
//  LumberJack
//
//  Created by Shashank Chaudhary on 2013-03-17.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeasurementTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblMeasurementType;
@property (weak, nonatomic) IBOutlet UILabel *lblMeasurementValue;
@property (weak, nonatomic) IBOutlet UILabel *lblMeasurementTime;

@end
