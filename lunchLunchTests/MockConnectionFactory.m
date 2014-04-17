//
// Created by Cyrus on 4/17/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockConnectionFactory.h"


@implementation MockConnectionFactory {
    id<NSURLConnectionDataDelegate> delegatePassedIn;
    NSString * requestURLPassedIn;
}
- (NSURLConnection *)buildAsynchronousRequestForURL:(NSString *)requestURL andDelegate:(id <NSURLConnectionDataDelegate>)delegate {
    requestURLPassedIn = requestURL;
    delegatePassedIn = delegate;
    return nil;
}

-(NSString *) getRequestURLPassedIn{
    return requestURLPassedIn;
}
-(id<NSURLConnectionDataDelegate>) getDelegatePassedIn{
    return delegatePassedIn;
}
@end