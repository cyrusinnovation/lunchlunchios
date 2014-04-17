//
// Created by Cyrus on 4/17/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionFactoryProtocol.h"


@interface MockConnectionFactory : NSObject<ConnectionFactoryProtocol>

- (NSString *)getRequestURLPassedIn;

- (id <NSURLConnectionDataDelegate>)getDelegatePassedIn;
@end