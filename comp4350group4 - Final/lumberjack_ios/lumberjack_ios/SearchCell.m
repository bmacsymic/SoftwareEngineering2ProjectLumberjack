//
//  SearchCell.m
//  LumberJack
//
//  Created by Kyle Andrew Pollock on 2013-03-15.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell
@synthesize nameLabel = _nameLabel;
@synthesize otherLabel = _otherLabel;
@synthesize thumbnailImageView = _thumbnailImageView;

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
