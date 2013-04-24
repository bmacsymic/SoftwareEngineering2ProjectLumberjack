//
//  AddSessionViewController.h
//  LumberJack
//
//  Created by Cameron Hrycyna on 3/9/13.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddSessionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *workout_name;
@property (weak, nonatomic) IBOutlet UIDatePicker *session_date;
@property (weak, nonatomic) IBOutlet UITextView *session_comments;
@property (weak, nonatomic) IBOutlet UIButton *btnAddSession;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
- (IBAction)addSession:(id)sender;
- (IBAction)cancel:(id)sender;
- (BOOL) validateFields;

@end
