//
//  HomeViewController.h
//  LumberJack
//
//  Created by Cameron Hrycyna on 2013-03-23.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSObject>

@property (strong, nonatomic) NSMutableArray* tableData;

@end
