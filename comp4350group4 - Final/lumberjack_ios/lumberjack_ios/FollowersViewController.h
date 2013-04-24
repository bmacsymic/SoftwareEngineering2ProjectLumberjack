//  FollowersViewController.h
//  LumberJack
//
//  Re-Created by Jeremy Randy Turcotte on 2013-03-09.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSObject>{
    ;
}

@property (weak, nonatomic) IBOutlet UIImageView *avatarVIew;
@property(readwrite, retain) IBOutlet NSMutableArray* followersTableData ;
@property (weak, nonatomic) IBOutlet UITableView *tblfollowers;

- (IBAction)menuOpen:(id)sender;
- (IBAction)goToNav:(id)sender;

@end
