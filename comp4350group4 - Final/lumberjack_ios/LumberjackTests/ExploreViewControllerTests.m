//
//  ExploreViewControllerTests.m
//  LumberJack
//
//  Created by Kyle Andrew Pollock on 2013-03-17.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "ExploreViewControllerTests.h"

@implementation ExploreViewControllerTests
ExploreViewController * view;
UIButton * workoutNameBtn;
UIButton * workoutDescriptionBtn;
UIButton * workoutAuthorBtn;
UIButton * workoutExerciseBtn;
UIButton * peopleBioBtn;
UIButton * peopleUsernameBtn;

-(void)setUp
{
    view = [[ExploreViewController alloc] init];
    
    workoutNameBtn        = [[UIButton alloc] init];
    workoutDescriptionBtn = [[UIButton alloc] init];
    workoutAuthorBtn      = [[UIButton alloc] init];
    workoutExerciseBtn    = [[UIButton alloc] init];
    peopleBioBtn          = [[UIButton alloc] init];
    peopleUsernameBtn     = [[UIButton alloc] init];
    
    [view setWorkoutNameBtn:workoutNameBtn];
    [view setWorkoutDescriptionBtn:workoutDescriptionBtn];
    [view setWorkoutAuthorBtn:workoutAuthorBtn];
    [view setWorkoutExerciseBtn:workoutExerciseBtn];
    [view setPeopleUsernameBtn:peopleUsernameBtn];
    [view setPeopleBioBtn:peopleBioBtn];

}

- (void)tearDown
{
    // Tear-down code here.
    [super tearDown];
    
    view                   = nil;
    workoutNameBtn         = nil;
    workoutDescriptionBtn  = nil;
    workoutAuthorBtn       = nil;
    workoutExerciseBtn     = nil;
    peopleBioBtn           = nil;
    peopleUsernameBtn      = nil;
}

- (void)testMD5
{
    NSString * hash = [view md5:@"kpollock9@hotmail.com"];
    STAssertTrue([hash isEqualToString:@"f3618bbb97aca6fb476884ccce7db985"], @"MD5 Gravatar hash incorrect");
}

- (void)testClearButtons
{
    [view clearButtons];
    
    STAssertTrue(view.workoutNameBtn.selected == NO, @"workout name button SHOULD not be selected");
    STAssertTrue(view.workoutDescriptionBtn.selected == NO, @"workout description button should NOT be selected");
    STAssertTrue(view.workoutAuthorBtn.selected == NO, @"workout author button should NOT be selected");
    STAssertTrue(view.workoutExerciseBtn.selected == NO, @"workout exercise button should NOT be selected");
    STAssertTrue(view.peopleBioBtn.selected == NO, @"people bio should NOT be selected");
    STAssertTrue(view.peopleUsernameBtn.selected == NO, @"people username button should NOT be selected");
    
}

- (void)testWorkoutNameButton
{

    [view workoutNameSelect:view];
    
    STAssertTrue(view.workoutNameBtn.selected == YES, @"workout name button SHOULD be selected");
    STAssertTrue(view.workoutDescriptionBtn.selected == NO, @"workout description button should NOT be selected");
    STAssertTrue(view.workoutAuthorBtn.selected == NO, @"workout author button should NOT be selected");
    STAssertTrue(view.workoutExerciseBtn.selected == NO, @"workout exercise button should NOT be selected");
    STAssertTrue(view.peopleBioBtn.selected == NO, @"people bio should NOT be selected");
    STAssertTrue(view.peopleUsernameBtn.selected == NO, @"people username button should NOT be selected");

}

- (void)testWorkoutDescriptionButton
{
    [view workoutDescriptionSelect:view];
    
    
    STAssertTrue(view.workoutNameBtn.selected == NO, @"workout name button SHOULD not be selected");
    STAssertTrue(view.workoutDescriptionBtn.selected == YES, @"workout description button SHOULD be selected");
    STAssertTrue(view.workoutAuthorBtn.selected == NO, @"workout author button should NOT be selected");
    STAssertTrue(view.workoutExerciseBtn.selected == NO, @"workout exercise button should NOT be selected");
    STAssertTrue(view.peopleBioBtn.selected == NO, @"people bio should NOT be selected");
    STAssertTrue(view.peopleUsernameBtn.selected == NO, @"people username button should NOT be selected");
    
}

- (void)testWorkoutAuthorButton
{

    [view workoutAuthorSelect:view];
    
    STAssertTrue(view.workoutNameBtn.selected == NO, @"workout name button SHOULD not be selected");
    STAssertTrue(view.workoutDescriptionBtn.selected == NO, @"workout description button should NOT be selected");
    STAssertTrue(view.workoutAuthorBtn.selected == YES, @"workout author button should be selected");
    STAssertTrue(view.workoutExerciseBtn.selected == NO, @"workout exercise button should NOT be selected");
    STAssertTrue(view.peopleBioBtn.selected == NO, @"people bio should NOT be selected");
    STAssertTrue(view.peopleUsernameBtn.selected == NO, @"people username button should NOT be selected");
    
}

- (void)testWorkoutExerciseButton
{
    [view workoutExerciseSelect:view];
    
    STAssertTrue(view.workoutNameBtn.selected == NO, @"workout name button SHOULD not be selected");
    STAssertTrue(view.workoutDescriptionBtn.selected == NO, @"workout description button should NOT be selected");
    STAssertTrue(view.workoutAuthorBtn.selected == NO, @"workout author button should NOT be selected");
    STAssertTrue(view.workoutExerciseBtn.selected == YES, @"workout exercise button should be selected");
    STAssertTrue(view.peopleBioBtn.selected == NO, @"people bio should NOT be selected");
    STAssertTrue(view.peopleUsernameBtn.selected == NO, @"people username button should NOT be selected");
    
}

- (void)testPeopleUsernameButton
{

    [view peopleUsernameSelect:view];
    
    STAssertTrue(view.workoutNameBtn.selected == NO, @"workout name button SHOULD not be selected");
    STAssertTrue(view.workoutDescriptionBtn.selected == NO, @"workout description button should NOT be selected");
    STAssertTrue(view.workoutAuthorBtn.selected == NO, @"workout author button should NOT be selected");
    STAssertTrue(view.workoutExerciseBtn.selected == NO, @"workout exercise button should NOT be selected");
    STAssertTrue(view.peopleUsernameBtn.selected == YES, @"people username button should be selected");
    STAssertTrue(view.peopleBioBtn.selected == NO, @"people bio should NOT be selected");
    
}

- (void)testPeopleBioExerciseButton
{
    [view peopleBioSelect:view];
    
    STAssertTrue(view.workoutNameBtn.selected == NO, @"workout name button SHOULD not be selected");
    STAssertTrue(view.workoutDescriptionBtn.selected == NO, @"workout description button should NOT be selected");
    STAssertTrue(view.workoutAuthorBtn.selected == NO, @"workout author button should NOT be selected");
    STAssertTrue(view.workoutExerciseBtn.selected == NO, @"workout exercise button should NOT be selected");
    STAssertTrue(view.peopleUsernameBtn.selected == NO, @"people username button should NOT be selected");
    STAssertTrue(view.peopleBioBtn.selected == YES, @"people email should be selected");
    
}
@end
