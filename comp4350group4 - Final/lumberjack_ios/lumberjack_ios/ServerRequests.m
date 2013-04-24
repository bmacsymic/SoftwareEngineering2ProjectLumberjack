//
//  ServerRequests.m
//  LumberJack
//
//  Created by Cameron Hrycyna on 3/10/13.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "ServerRequests.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@implementation ServerRequests


/*****************************************************
 *   ______________________________________________  *
 *  /                                              \ *
 *  |   WHATEVER YOU DO, DON'T PUSH WITH YOUR      | *
 *  |   OWN DEVELOPMENT SERVER. IF ZAPP SNAPSHOTS  | *
 *  |    HIS MOBILE APP WILL NOT WORK!!!!!!!!!     | *
 *  \__________________   _________________________/ *
 *                     \ /                           *
 * .            .--.    V                            *
 * \\          //\\ \                                *
 * .\\        ///_\\\\                               *
 * :/>`      /(| `|'\\\                              *
 *  Y/\      )))\_-_/((\                             *
 *   \ \    ./'_/ " \_`\)                            *
 *    \ \.-" ._ \   /   \                            *
 *     \ _.-" (_ \Y/ _) |                            *
 *      "      )" | ""/||                            *
 *          .-'  .'  / ||                            *
 *         /    `   /  ||                            *
 *        |    __  :   ||_                           *
 *        |   / \   \ '|\`                           *
 *        |  |   \   \                               *
 *        |  |    `.  \                              *
 *        |  |      \  \                             *
 *        |  |       \  \                            *
 *        |  |        \  \                           *
 *        |  |         \  \                          *
 *        /__\          |__\                         *
 *        /.|            |.\_                        *
 *       `-''            ``--'                       *
 *                                                   *
 *****************************************************/
NSString* server_url = @"http://ec2-54-234-138-149.compute-1.amazonaws.com:6001/"; //DON'T CHANGE THIS!

//NSString * server_url = @"http://ec2-50-16-177-84.compute-1.amazonaws.com:5000/";

//NSString * server_url = @"http://ec2-204-236-195-129.compute-1.amazonaws.com:5000/";

//Brad's
//NSString * server_url = @"http://ec2-54-242-135-239.compute-1.amazonaws.com:5000/";

+ (ASIHTTPRequest *)serverJSONPost:(NSString *)server_call json:(NSData *)json
{
    NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    NSString * urlString = [NSString stringWithFormat:@"%@%@", server_url, server_call];
    NSURL * url = [NSURL URLWithString:urlString];
    NSLog(@"%@",urlString);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request appendPostData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setRequestMethod:@"POST"];
    [request startSynchronous];
    return request;
}


+ (NSDictionary *)serverFormPost:(NSString *)server_call data:(NSDictionary *) data
{
    
    NSDictionary * result = nil;
    
    NSString * urlString = [NSString stringWithFormat:@"%@%@", server_url, server_call];
    NSURL * url = [NSURL URLWithString:urlString];
    NSLog(@"%@",urlString);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    
    //marshalling
    for(id key in data)
    {
        [request setPostValue:[data objectForKey:key] forKey:key];
    }

    [request startSynchronous];
    
    NSError *error = [request error];
    if (!error)
    {
        NSString *response = [request responseString];
        NSLog(@"%@", response);
        NSData * responseData = [request responseData];
        result = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    }
    else
    {
        NSLog(@"Error : %@",[error domain]);
    }

    return result;
}

+ (NSDictionary *)serverGetRequest:(NSString *)server_call data:(NSDictionary *) data
{
    NSDictionary * result = nil;
    
    NSString * delimiter = @"?";
    NSString * appended = @"";
    NSString * urlString = [NSString stringWithFormat:@"%@%@", server_url, server_call];
    
    if(data != nil)
    {
        for (id key in data)
        {
            //still needs to replace splaces with other characters
            //urlString += delimiter + data[i];
            appended  = [NSString stringWithFormat: @"%@%@=%@",delimiter,key,[data objectForKey:key]];
            urlString = [NSString stringWithFormat: @"%@%@", urlString, appended];
            delimiter = @"&"; //delimiter changes after the first argument
        }
    }
    
    NSLog(@"%@", urlString);
    NSURL * url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSString *response = [request responseString];
        NSLog(@"%@", response);
        NSData * responseData = [request responseData];
        result = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    }
    else
    {
        NSLog(@"Error : %@",[error domain]);
    }
    return result;
}
@end
