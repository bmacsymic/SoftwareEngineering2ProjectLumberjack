//
//  UtilityTests.m
//  LumberJack
//
//  Created by Shashank Chaudhary on 2013-03-17.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "UtilityTests.h"
#import "Utility.h"
@implementation UtilityTests

- (void)testTrimWithSpaces
{
    NSString * testString = @"hello       ";
    NSString * resultString = [Utility trim:testString];
    STAssertTrue([ resultString isEqualToString:@"hello"], @"We expected YES, but it was NO");
}

- (void)testTrimWithSpacesInBegining
{
    NSString * testString = @"    hello       ";
    NSString * resultString = [Utility trim:testString];
    STAssertTrue([ resultString isEqualToString:@"hello"], @"We expected YES, but it was NO");
}

- (void)testTrimWithSpacesAndNewlines
{
    NSString * testString = @"   \n\n\n\n hello       \n\n\n\n";
    NSString * resultString = [Utility trim:testString];
    STAssertTrue([ resultString isEqualToString:@"hello"], @"We expected YES, but it was NO");
}

- (void)testTrimWithEmptyString
{
    NSString * testString = @"      \n\n     ";
    NSString * resultString = [Utility trim:testString];
    STAssertTrue([ resultString isEqualToString:@""], @"We expected YES, but it was NO");
}

- (void)testIsNumberValidInt
{
    NSString * testString = @"345";
    BOOL result = [Utility isNumber:testString];
    STAssertTrue(result, @"We expected YES, but it was NO");
}

- (void)testIsNumberValidDecimal
{
    NSString * testString = @"345.452";
    BOOL result = [Utility isNumber:testString];
    STAssertTrue(result, @"We expected YES, but it was NO");
}

- (void)testIsNumberInvalid
{
    NSString * testString = @"345.452aaa";
    BOOL result = [Utility isNumber:testString];
    STAssertFalse(result, @"We expected YES, but it was NO");
}
@end
