//
//  ServerRequests.h
//  LumberJack
//
//  Created by Cameron Hrycyna on 3/10/13.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
@interface ServerRequests : NSObject

@property(readonly, nonatomic) NSString* server_url;

+ (ASIHTTPRequest *)serverJSONPost:(NSString *)server_call json:(NSData *)json;
+ (NSDictionary *)serverFormPost:(NSString *)server_call data:(NSDictionary *)data;
+ (NSDictionary *)serverGetRequest:(NSString *)server_call data:(NSDictionary *) data;

@end
