//
//  AddSessionViewControllerTest.m
//  LumberJack
//
//  Created by Cameron Hrycyna on 2013-03-20.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "AddSessionViewControllerTest.h"
#import "AddSessionViewController.h"

@implementation AddSessionViewControllerTest

AddSessionViewController * view;
UITextField * wName;
UITextView * comments;
-(void) setUp
{
    [super setUp];
    view = [[AddSessionViewController alloc] init];
    wName = [[UITextField alloc ] init];
    comments = [[UITextView alloc ] init];
    wName.text = @" ";
    comments.text = @" ";
    
    [view setWorkout_name:wName];
    [view setSession_comments:comments];
}


-(void) tearDown
{
    view = nil;
    wName.text = nil;
    comments.text = nil;
    [super tearDown];
}

-(void) testIsValidInputEmptyWorkoutNameField
{
    wName.text = @"";
    [view setWorkout_name:wName];
    BOOL result = [view validateFields];
    
    STAssertFalse(result, @"We expected NO, but it was YES");
}

-(void) testIsValidInputyWorkoutNameField
{
    wName.text = @"Shaw's Lazy Workout";
    [view setWorkout_name:wName];
    BOOL result = [view validateFields];
    
    STAssertTrue(result, @"We expected YES, but it was NO");
}

-(void) testIsValidInputEmptyCommentsField
{
    comments.text = @"";
    [view setSession_comments:comments];
    BOOL result = [view validateFields];
    
    STAssertFalse(result, @"We expected NO, but it was YES");
}


-(void) testIsValidInputyCommentsField
{
    comments.text = @"Unit Test - Add Session";
    [view setSession_comments:comments];
    BOOL result = [view validateFields];
    
    STAssertTrue(result, @"We expected Tes, but it was NO");
}
@end
