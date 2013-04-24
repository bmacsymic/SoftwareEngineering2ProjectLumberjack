//
//  FeedCell.h
//  LumberJack
//
//  Created by Lianfeng Luo on 2013-03-16.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *postText;

@end
