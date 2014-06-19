//
// Created by Cyrus on 4/16/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "ConnectionFactory.h"


@implementation ConnectionFactory {

}

- (NSURLConnection *)buildAsynchronousGetRequestForURL:(NSString *)requestURL andDelegate:(id <NSURLConnectionDataDelegate>)delegate {

    NSURL * url = [NSURL URLWithString:requestURL];
    NSURLRequest * request = [NSURLRequest requestWithURL:url ];

    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:delegate];


    return connection;
}

- (NSURLConnection *)postData:(NSData *)data toURL:(NSString *)requestUrl withDelegate:(id <NSURLConnectionDataDelegate>)delegate {
    NSURL * url = [NSURL URLWithString:requestUrl];

    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];

    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    NSURLConnection* connection =[[NSURLConnection alloc] initWithRequest:request delegate:delegate];

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