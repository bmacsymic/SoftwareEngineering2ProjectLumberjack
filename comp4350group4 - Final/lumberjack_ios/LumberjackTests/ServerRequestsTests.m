//
//  ServerRequestsTests.m
//  LumberJack
//
//  Created by Bradley Macsymic on 2013-03-25.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "ServerRequestsTests.h"
#import "ServerRequests.h"

@implementation ServerRequestsTests

- (void)testServerJSONPost
{
    ASIHTTPRequest *request = [ServerRequests serverJSONPost:@"workouts/submitWorkout" json:Nil];
    NSError *error = [request error];
    BOOL result;
    if(!error)
    {
        result = true;
    }
    else
    {
        result = false;
    }
    
    STAssertTrue(result, @"We expected YES, but it was NO");
}

- (void)testServerFormPost
{
    NSDictionary *request = [ServerRequests serverFormPost:(@"workouts/getWorkouts") data:Nil];
    BOOL result;
    
    if(request != nil && [[request objectForKey:@"Result"] isEqual: @"OK"])
    {
        result = true;
    }
    else
    {
        result = false;
    }
    
    STAssertTrue(result, @"We expected YES, but it was NO");
}

- (void)testServerGetRequest
{
	NSDictionary * request = [ServerRequests serverGetRequest:@"workouts/getExerciseTypes" data:nil];
    BOOL result;
    
    if (request != nil)
    {
        result = true;
    }
    else
    {
        result = false;
    }
    
    STAssertTrue(result, @"We expected YES, but it was NO");
}

@end
