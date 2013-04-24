//
//  EditProfileViewControllerTests.m
//  LumberJack
//
//  Created by Lianfeng Luo on 2013-03-17.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "EditProfileViewControllerTests.h"

@implementation EditProfileViewControllerTests

EditProfileViewController *view;
UITextField *label;
UITextField *fNameLabel;
UITextField *lNameLabel;
UITextField *emailLabel;
UITextView *aboutLabel;

- (void)setUp
{
    [super setUp];
    // Set-up code here.
    view = [[EditProfileViewController alloc] init];
    label = [[UITextField alloc] init];
    fNameLabel = [[UITextField alloc] init];
    fNameLabel.text = @"fName";
    [view setFirstNameField:fNameLabel];
    lNameLabel = [[UITextField alloc] init];
    lNameLabel.text = @"lName";
    [view setLastNameField:fNameLabel];
    emailLabel = [[UITextField alloc] init];
    emailLabel.text = @"email";
    [view setEmailField:emailLabel];
    aboutLabel = [[UITextView alloc] init];
    aboutLabel.text = @"about";
    [view setAboutField:aboutLabel];
}

- (void)tearDown
{
    // Tear-down code here.
    view = nil;
    label = nil;
    fNameLabel = nil;
    lNameLabel = nil;
    emailLabel = nil;
    aboutLabel = nil;
    
    [super tearDown];
}

- (void)testIsValidInputEmptyFirstNameValue
{
    fNameLabel.text = nil;
    [view setFirstNameField:fNameLabel];
    
    BOOL result = [view isValidInput];
    
    STAssertFalse(result, @"We expected NO, but it was YES");
}

- (void)testIsValidInputEmptyLastNameValue
{
    lNameLabel.text = nil;
    [view setLastNameField:lNameLabel];
    
    BOOL result = [view isValidInput];
    
    STAssertFalse(result, @"We expected NO, but it was YES");
}

- (void)testIsValidInputEmptyEmailValue
{
    emailLabel.text = nil;
    [view setEmailField:emailLabel];
    
    BOOL result = [view isValidInput];
    
    STAssertFalse(result, @"We expected NO, but it was YES");
}

- (void)testIsValidInputAboutValue
{
    aboutLabel.text = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim";
    [view setAboutField:aboutLabel];
    
    BOOL result = [view isValidInput];
    
    STAssertFalse(result, @"We expected NO, but it was YES");
}

- (void)testIsValidInputWithFirstNameValue
{    
    BOOL result = [view isValidInput];
    
    STAssertTrue(result, @"We expected YES, but it was NO");
}

- (void)testIsValidInputWithLastNameValue
{    
    BOOL result = [view isValidInput];
    
    STAssertTrue(result, @"We expected YES, but it was NO");
}

- (void)testIsValidInputWithEmailValue
{    
    BOOL result = [view isValidInput];
    
    STAssertTrue(result, @"We expected YES, but it was NO");
}

- (void)testIsValidInputWithAboutValue
{    
    BOOL result = [view isValidInput];
    
    STAssertTrue(result, @"We expected YES, but it was NO");
}

@end

