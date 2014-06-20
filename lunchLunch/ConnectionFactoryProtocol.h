//
// Created by Cyrus on 4/16/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConnectionFactoryProtocol <NSObject>
- (NSURLConnection *)buildAsynchronousGetRequestForURL:(NSString *)requestURL andDelegate:(id<NSURLConnectionDataDelegate>) delegate;
-(NSURLConnection*)postData:(NSData *)data toURL:(NSString *)url withDelegate:(id<NSURLConnectionDataDelegate>) delegate;
-(void) openURL: (NSString *) url;
@end