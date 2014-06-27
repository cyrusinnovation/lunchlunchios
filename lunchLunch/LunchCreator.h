//
// Created by Cyrus on 4/22/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LunchCreatorProtocol.h"
#import "ConnectionFactoryProtocol.h"
#import "LunchParserProtocol.h"
#import "PersonParserProtocol.h"
#import "LunchReceiverProtocol.h"

@protocol LunchCreationHandler;

@interface LunchCreator : NSObject <NSURLConnectionDataDelegate, LunchCreatorProtocol>
- (id)initWithConnectionFactory:(NSObject <ConnectionFactoryProtocol> *)factory lunchParser:(NSObject <LunchParserProtocol> *)lunchParserForInit andLunchCreationHandler:(NSObject <LunchCreationHandler> *)createHandler;

- (NSObject <ConnectionFactoryProtocol> *)getConnectionFactory;

- (NSObject <LunchParserProtocol> *)getLunchParser;

- (NSObject <LunchCreationHandler> *)getLunchCreationHandler;
@end