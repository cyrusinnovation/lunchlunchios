//
// Created by Cyrus on 4/17/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionFactoryProtocol.h"


@interface MockConnectionFactory : NSObject<ConnectionFactoryProtocol>

- (id <NSURLConnectionDataDelegate>)getDelegatePassedInForPut;

- (NSData *)getDataPassedInToPut;

- (NSString *)getRequestURLPassedInForPost;

- (id <NSURLConnectionDataDelegate>)getDelegatePassedInForPost;

- (NSData *)getDataPassedInToPost;

- (NSString *)getRequestURLPassedInForGet;

- (id <NSURLConnectionDataDelegate>)getDelegatePassedInForGet;

-(NSString *) getURLOpened;

- (NSString *)getRequestURLPassedInForPut;
@end