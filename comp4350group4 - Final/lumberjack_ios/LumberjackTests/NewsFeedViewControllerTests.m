//
//  NewsFeedViewControllerTests.m
//  LumberJack
//
//  Created by Lianfeng Luo on 2013-03-23.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "NewsFeedViewControllerTests.h"

@implementation NewsFeedViewControllerTests

NewsFeedViewController *view;
UITextField *postStatus;

- (void)setUp
{
    [super setUp];
    // Set-up code here.
    view = [[NewsFeedViewController alloc] init];
    postStatus = [[UITextField alloc] init];
}

- (void)tearDown
{
    // Tear-down code here.
    view = nil;
    postStatus = nil;
    
    [super tearDown];
}

- (void)testIsValidInputEmptyPostStatusReturnsNo
{
    postStatus.text = @"";
    [view setStatusText:postStatus];
    
    BOOL result = [view isValidInput];
    
    STAssertFalse(result, @"We expected NO, but it was YES");
}

- (void)testIsValidInputExceedMaxCharsReturnsNo
{
    postStatus.text = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim";
    [view setStatusText:postStatus];
    
    BOOL result = [view isValidInput];
    
    STAssertFalse(result, @"We expected NO, but it was YES");
}

- (void)testIsValidInputWithValidInputReturnsYes
{
    postStatus.text = @"Hello World!";
    [view setStatusText:postStatus];
    
    BOOL result = [view isValidInput];
    
    STAssertTrue(result, @"We expected YES, but it was NO");
}


@end
