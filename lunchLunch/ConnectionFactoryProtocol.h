//
// Created by Cyrus on 4/16/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConnectionFactoryProtocol <NSObject>
- (NSURLConnection *)buildAsynchronousRequestForURL: (NSString *) requestURL andDelegate:(id<NSURLConnectionDataDelegate>) delegate;
@end