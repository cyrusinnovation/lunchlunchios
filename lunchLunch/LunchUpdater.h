//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LunchUpdaterProtocol.h"

#import "ConnectionFactoryProtocol.h"
#import "LocationParserProtocol.h"
#import "LunchUpdateHandler.h"


@interface LunchUpdater : NSObject <NSURLConnectionDataDelegate, LunchUpdaterProtocol>
- (id)initWithConnectionFactory:(NSObject <ConnectionFactoryProtocol> *)factory andUpdateHandler:(NSObject <LunchUpdateHandler> *)handler;
-(NSObject<ConnectionFactoryProtocol>  *)getConnectionFactory;
-(NSObject<LunchUpdateHandler>  *)getUpdateHandler;
@end