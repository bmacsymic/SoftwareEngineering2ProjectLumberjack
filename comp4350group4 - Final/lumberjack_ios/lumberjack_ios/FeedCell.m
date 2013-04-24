//
//  FeedCell.m
//  LumberJack
//
//  Created by Lianfeng Luo on 2013-03-16.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "FeedCell.h"

@implementation FeedCell
@synthesize avatarImageView;
@synthesize authorLabel;
@synthesize dateLabel;
@synthesize postText;

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
