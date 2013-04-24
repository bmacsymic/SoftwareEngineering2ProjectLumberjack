//
//  NavButtonsViewController.h
//  LumberJack
//
//  Created by Cameron Hrycyna on 3/22/13.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"

@interface NavButtonsViewController : UIViewController

- (IBAction)history:(id)sender;
- (IBAction)followers:(id)sender;
- (IBAction)Profile:(id)sender;
- (IBAction)newsfeed:(id)sender;
- (IBAction)measurement:(id)sender;
- (IBAction)workout:(id)sender;

@end
