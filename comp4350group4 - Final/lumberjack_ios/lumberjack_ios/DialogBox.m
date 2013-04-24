//
//  DialogBox.m
//  LumberJack
//
//  Created by Shashank Chaudhary on 2013-03-11.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "DialogBox.h"

@implementation DialogBox
+ (void)alertTitle: (NSString *) title alertMessage: (NSString *) message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
@end
