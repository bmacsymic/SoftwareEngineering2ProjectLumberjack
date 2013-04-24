//
//  NewsFeedViewController.h
//  LumberJack
//
//  Created by Lianfeng Luo on 2013-03-09.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsFeedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSObject>{
}
- (IBAction)menuOpen:(id)sender;

@property (strong, nonatomic) NSMutableArray* tableData;
@property (weak, nonatomic) IBOutlet UITableView *feedsTableView;
@property (weak, nonatomic) IBOutlet UITextField *statusText;
@property (weak, nonatomic) IBOutlet UIButton *btnPost;
- (IBAction)postStatus:(id)sender;
- (IBAction)goToNav:(id)sender;
- (BOOL)isValidInput;

@end
