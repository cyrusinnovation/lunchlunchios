//
// Created by Cyrus on 4/16/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "ConnectionFactory.h"


@implementation ConnectionFactory {

}

- (NSURLConnection *)buildAsynchronousGetRequestForURL:(NSString *)requestURL andDelegate:(id <NSURLConnectionDataDelegate>)delegate {

    NSURL *url = [NSURL URLWithString:requestURL];
    NSURLRequest *request = [self buildRequest:url];

    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:delegate];


    return connection;
}

- (NSURLConnection *)postData:(NSData *)data toURL:(NSString *)requestUrl withDelegate:(id <NSURLConnectionDataDelegate>)delegate {
    return [self getConnection:data requestUrl:requestUrl delegate:delegate andConnectionType:@"POST"];

}

- (NSURLConnection *)putData:(NSData *)data toURL:(NSString *)requestUrl withDelegate:(id <NSURLConnectionDataDelegate>)delegate {
    return [self getConnection:data requestUrl:requestUrl delegate:delegate andConnectionType:@"PUT"];;
}


- (void)openURL:(NSString *)url {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];

}

- (NSURLConnection *)getConnection:(NSData *)data requestUrl:(NSString *)requestUrl
                          delegate:(id <NSURLConnectionDataDelegate>)delegate andConnectionType:(NSString *)connectionType {
    NSURL *url = [NSURL URLWithString:requestUrl];

    NSString *dataLength = [NSString stringWithFormat:@"%lu", (unsigned long) [data length]];
    NSMutableURLRequest *request = [self buildRequest:url];

    [request setHTTPMethod:connectionType];
    [request setHTTPBody:data];

    [request setValue:dataLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:delegate];

    return connection;
}

- (NSMutableURLRequest *)buildRequest:(NSURL *)url {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"794a8e8f-9654-40cb-a576-635462307c37" forHTTPHeaderField:@"api_key"];
    return request;
}





+ (ConnectionFactory *)singleton {
    static ConnectionFactory *SINGLETON;
    if (!SINGLETON) {
        SINGLETON = [[ConnectionFactory alloc] init];

    }
    return SINGLETON;
}


@end