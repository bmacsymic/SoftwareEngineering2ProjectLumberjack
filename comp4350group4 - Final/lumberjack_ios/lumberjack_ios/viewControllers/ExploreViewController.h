//
//  ExploreViewController.h
//  LumberJack
//
//  Created by Kyle Andrew Pollock on 2013-03-09.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "user.h"

@interface ExploreViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
- (IBAction)workoutNameSelect:(id)sender;
- (IBAction)peopleBioSelect:(id)sender;
- (IBAction)peopleUsernameSelect:(id)sender;
- (IBAction)workoutExerciseSelect:(id)sender;
- (IBAction)workoutAuthorSelect:(id)sender;
- (IBAction)workoutDescriptionSelect:(id)sender;
- (void)clearButtons;
- (BOOL)isServerAccessable;
- (NSString *) md5:(NSString *)str;
@property (weak, nonatomic) IBOutlet UIButton *workoutAuthorBtn;
@property (weak, nonatomic) IBOutlet UIButton *workoutExerciseBtn;
@property (weak, nonatomic) IBOutlet UIButton *peopleUsernameBtn;
@property (weak, nonatomic) IBOutlet UIButton *peopleBioBtn;
@property (weak, nonatomic) IBOutlet UIButton *workoutNameBtn;
@property (weak, nonatomic) IBOutlet UIButton *workoutDescriptionBtn;
@property (nonatomic, retain) User * user;
@property (strong, nonatomic) NSMutableArray* filteredSearchTableData;
@end
