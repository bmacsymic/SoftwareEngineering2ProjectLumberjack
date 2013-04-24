//
//  Utility.m
//  LumberJack
//
//  Created by Shashank Chaudhary on 2013-03-17.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+(NSString *) trim: (NSString*) str
{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (BOOL) isNumber: (NSString*) str
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber * number = [formatter numberFromString: str];
    return (number != nil);
}
@end
