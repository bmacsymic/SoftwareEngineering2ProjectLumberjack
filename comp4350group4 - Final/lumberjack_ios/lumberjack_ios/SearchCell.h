//
//  SearchCell.h
//  LumberJack
//
//  Created by Kyle Andrew Pollock on 2013-03-15.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *otherLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@end
