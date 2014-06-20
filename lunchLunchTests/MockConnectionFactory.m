//
// Created by Cyrus on 4/17/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockConnectionFactory.h"


@implementation MockConnectionFactory {
    id <NSURLConnectionDataDelegate> delegatePassedInForGet;
    NSString *requestURLPassedInForGet;
    id <NSURLConnectionDataDelegate> delegatePassedInToPost;
    NSData *dataPassedInToPost;
    NSString *requestURLPassedInForPost;
    NSString *urlOpened;
}
- (NSURLConnection *)buildAsynchronousGetRequestForURL:(NSString *)requestURL andDelegate:(id <NSURLConnectionDataDelegate>)delegate {
    requestURLPassedInForGet = requestURL;
    delegatePassedInForGet = delegate;
    return nil;
}

- (NSURLConnection *)postData:(NSData *)data toURL:(NSString *)url withDelegate:(id <NSURLConnectionDataDelegate>)delegate {
    requestURLPassedInForPost = url;
    dataPassedInToPost = data;
    delegatePassedInToPost = delegate;
    return nil;
}

- (void)openURL:(NSString *)url {
    urlOpened = url;
}
-(NSString *) getURLOpened{
    return urlOpened;
}

- (NSString *)getRequestURLPassedInForPost {
    return requestURLPassedInForPost;
}

- (id <NSURLConnectionDataDelegate>)getDelegatePassedInForPost {
    return delegatePassedInToPost;
}

- (NSData *)getDataPassedInToPost {
    return dataPassedInToPost;
}

- (NSString *)getRequestURLPassedInForGet {
    return requestURLPassedInForGet;
}

- (id <NSURLConnectionDataDelegate>)getDelegatePassedInForGet {
    return delegatePassedInForGet;
}
@end