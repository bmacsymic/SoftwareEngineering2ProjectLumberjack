//
//  AddMeasurementViewControllerTest.m
//  LumberJack
//
//  Created by Shashank Chaudhary on 2013-03-17.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "AddMeasurementViewControllerTest.h"

@implementation AddMeasurementViewControllerTest

AddMeasurementViewController * view;
UITextField * textField;
UITextField * tf1;
UITextField * tf2;
UITextField * tf3;
-(void) setUp
{
    [super setUp];
    view = [[AddMeasurementViewController alloc] init];
    textField = [[UITextField alloc ] init];
    tf1 = [[UITextField alloc ] init];
    tf2 = [[UITextField alloc ] init];
    tf3 = [[UITextField alloc ] init];
    tf1.text = @"Height";
    tf2.text = @"cm";
    tf3.text = @"123";
    [view setTxtMeasurementType:tf1];
    [view setTxtUnit:tf2];
    [view setTxtValue:tf3];
}


-(void) tearDown
{
    view = nil;
    textField = nil;
    [super tearDown];
}

-(void) testIsValidInputEmptyTypeField
{
    textField.text = @" ";
    [view setTxtMeasurementType:textField];
    BOOL result = [view validateFields];
    
    STAssertFalse(result, @"We expected NO, but it was YES");
}

-(void) testIsValidInputValidTypeField
{
    textField.text = @"hello";
    [view setTxtMeasurementType:textField];
    BOOL result = [view validateFields];
    
    STAssertTrue(result, @"We expected YES, but it was NO");
}

-(void) testIsValidInputEmptyUnitField
{
    textField.text = @"";
    [view setTxtUnit:textField];
    BOOL result = [view validateFields];
    STAssertFalse(result, @"We expected No, but it was YES");
}

-(void) testIsValidInputValidUnitField
{
    textField.text = @"cm";
    [view setTxtUnit:textField];
    BOOL result = [view validateFields];
    STAssertTrue(result, @"We expected YES, but it was NO");
}

-(void) testIsValidInputValidValueField
{
    textField.text = @"345";
    [view setTxtValue:textField];
    BOOL result = [view validateFields];
    STAssertTrue(result, @"We expected YES, but it was NO");
}

-(void) testIsValidInputEmptyValueField
{
    textField.text = @"";
    [view setTxtValue:textField];
    BOOL result = [view validateFields];
    STAssertFalse(result, @"We expected NO, but it was YES");
}

-(void) testIsValidInputInvalidValueField
{
    textField.text = @"invalid string";
    [view setTxtValue:textField];
    BOOL result = [view validateFields];
    STAssertFalse(result, @"We expected NO, but it was YES");
}
@end
