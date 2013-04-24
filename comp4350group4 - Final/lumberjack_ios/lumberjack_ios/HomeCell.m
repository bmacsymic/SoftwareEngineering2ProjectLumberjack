//
//  HomeCell.m
//  LumberJack
//
//  Created by Cameron Hrycyna on 2013-03-23.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

@synthesize workoutName = _workoutName;
@synthesize workoutDescription = _workoutDescription;
@synthesize background = _background;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
