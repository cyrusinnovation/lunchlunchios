//
// Created by Cyrus on 6/26/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationCreationHandler.h"
#import "LocationParserProtocol.h"
#import "ConnectionFactoryProtocol.h"
#import "LocationWriterProtocol.h"

@interface LocationWriter : NSObject<NSURLConnectionDataDelegate, LocationWriterProtocol>

- (NSObject <LocationParserProtocol>*)getLocationParser;
- (NSObject <ConnectionFactoryProtocol>*)getConnectionFactory;
- (NSObject <LocationCreationHandler>*)getLocationCreationHandler;
- (id)initWithConnectionFactory:(NSObject <ConnectionFactoryProtocol> *)factory parser:(NSObject <LocationParserProtocol> *)parser andCreationHandler:(NSObject <LocationCreationHandler> *)handler;


@end