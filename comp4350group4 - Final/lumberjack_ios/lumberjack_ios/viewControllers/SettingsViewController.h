//
//  SettingsViewController.h
//  LumberJack
//
//  Created by Shashank Chaudhary on 2013-03-12.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnLogIn;
@property (weak, nonatomic) IBOutlet UIButton *btnLogOut;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
- (IBAction)logout:(id)sender;

@end
