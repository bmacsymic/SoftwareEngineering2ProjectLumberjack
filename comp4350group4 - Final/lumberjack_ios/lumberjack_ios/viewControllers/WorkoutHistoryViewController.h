//
//  WorkoutHistoryViewController.h
//  LumberJack
//
//  Created by Cameron Hrycyna on 3/10/13.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkoutHistoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuOpen;
- (IBAction)menuOpen:(id)sender;
- (IBAction)goToNav:(id)sender;

@end
