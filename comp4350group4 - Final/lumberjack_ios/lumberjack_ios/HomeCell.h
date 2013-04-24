//
//  HomeCell.h
//  LumberJack
//
//  Created by Cameron Hrycyna on 2013-03-23.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *workoutName;
@property (weak, nonatomic) IBOutlet UILabel *workoutDescription;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@end
