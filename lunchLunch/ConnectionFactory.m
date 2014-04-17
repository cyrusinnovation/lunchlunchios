//
// Created by Cyrus on 4/16/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "ConnectionFactory.h"


@implementation ConnectionFactory {

}

- (NSURLConnection *)buildAsynchronousRequestForURL:(NSString *)requestURL andDelegate:(id <NSURLConnectionDataDelegate>)delegate {
    NSURL * url = [[NSURL alloc] initWithString:requestURL];
    NSURLRequest * request = [NSURLRequest requestWithURL:url ];

    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:delegate];


    return connection;
}

+ (ConnectionFactory *)singleton {
    static ConnectionFactory *SINGLETON;
    if(!SINGLETON){
        SINGLETON = [[ConnectionFactory alloc]init];

    }
    return SINGLETON;
}


@end