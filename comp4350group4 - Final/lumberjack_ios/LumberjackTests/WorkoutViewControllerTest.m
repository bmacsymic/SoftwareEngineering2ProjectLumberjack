//
//  WorkoutViewControllerTest.m
//  LumberJack
//
//  Created by Bradley Macsymic on 2013-03-20.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "WorkoutViewControllerTest.h"

@implementation WorkoutViewControllerTest

WorkoutViewController *view;
UITextField *workoutName;

- (void)setUp
{
    [super setUp];
    view = [[WorkoutViewController alloc] init];
    workoutName = [[UITextField alloc] init];
}

- (void)tearDown
{
    [super tearDown];
    view = nil;
    workoutName = nil;
}

- (void)testWorkoutIsValidInputNilValue
{
    workoutName.text = nil;
    [view setWorkoutNameTextField:workoutName];
    
    BOOL result = [view workoutIsValidInput];
    
    STAssertFalse(result, @"We expected NO, but it was YES");
}

- (void)testWorkoutIsValidInputEmptyValue
{
    workoutName.text = @"";
    [view setWorkoutNameTextField:workoutName];
    
    BOOL result = [view workoutIsValidInput];
    
    STAssertFalse(result, @"We expected NO, but it was YES");
}

- (void)testWorkoutIsValidInputRepeatValue
{
    workoutName.text = @"Jeremy's Meh Workout";
    [view setWorkoutNameTextField:workoutName];
    
    BOOL result = [view workoutIsValidInput];
    
    STAssertFalse(result, @"We expected NO, but it was YES");
}

- (void)testTriggerPublic
{
    [view setSelectedPublic:false];
    NSString *resultString = [view triggerPublic];
    BOOL resultBool = [resultString isEqual: @"UnselectedPublic"];
    STAssertTrue(resultBool, @"We expected Yes, but it was No");
    
    [view setSelectedPublic:false];
    resultString = [view triggerPublic];
    resultBool = [resultString isEqual: @"SelectedPublic"];
    STAssertFalse(resultBool, @"We expected NO, but it was YES");
    
    [view setSelectedPublic:true];
    resultString = [view triggerPublic];
    resultBool = [resultString isEqual: @"SelectedPublic"];
    STAssertTrue(resultBool, @"We expected Yes, but it was No");
    
    [view setSelectedPublic:true];
    resultString = [view triggerPublic];
    resultBool = [resultString isEqual: @"UnselectedPublic"];
    STAssertFalse(resultBool, @"We expected NO, but it was YES");
}

- (void)testTriggerLikeable
{
    [view setSelectedLikeable:false];
    NSString *resultString = [view triggerLikeable];
    BOOL resultBool = [resultString isEqual: @"UnselectedLikeable"];
    STAssertTrue(resultBool, @"We expected Yes, but it was No");
    
    [view setSelectedLikeable:false];
    resultString = [view triggerLikeable];
    resultBool = [resultString isEqual: @"SelectedLikeable"];
    STAssertFalse(resultBool, @"We expected NO, but it was YES");
    
    [view setSelectedLikeable:true];
    resultString = [view triggerLikeable];
    resultBool = [resultString isEqual: @"SelectedLikeable"];
    STAssertTrue(resultBool, @"We expected Yes, but it was No");
    
    [view setSelectedLikeable:true];
    resultString = [view triggerLikeable];
    resultBool = [resultString isEqual: @"UnselectedLikeable"];
    STAssertFalse(resultBool, @"We expected NO, but it was YES");
}

- (void)testTriggerCommentable
{
    [view setSelectedCommentable:false];
    NSString *resultString = [view triggerCommentable];
    BOOL resultBool = [resultString isEqual: @"UnselectedCommentable"];
    STAssertTrue(resultBool, @"We expected Yes, but it was No");
    
    [view setSelectedCommentable:false];
    resultString = [view triggerCommentable];
    resultBool = [resultString isEqual: @"SelectedCommentable"];
    STAssertFalse(resultBool, @"We expected NO, but it was YES");
    
    [view setSelectedCommentable:true];
    resultString = [view triggerCommentable];
    resultBool = [resultString isEqual: @"SelectedCommentable"];
    STAssertTrue(resultBool, @"We expected Yes, but it was No");
    
    [view setSelectedCommentable:true];
    resultString = [view triggerCommentable];
    resultBool = [resultString isEqual: @"UnselectedCommentable"];
    STAssertFalse(resultBool, @"We expected NO, but it was YES");
}

@end
