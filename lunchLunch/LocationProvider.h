//
// Created by Cyrus on 6/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationProviderProtocol.h"
#import "LocationParserProtocol.h"
#import "ConnectionFactoryProtocol.h"
#import "LocationReceiverProtocol.h"


@interface LocationProvider : NSObject<NSURLConnectionDataDelegate, LocationProviderProtocol>
- (id)initWithConnectionFactory:(NSObject <ConnectionFactoryProtocol> *)factory parser:(NSObject <LocationParserProtocol> *)parser andLocationReceiver:(NSObject <LocationReceiverProtocol> *)receiver;

-(NSObject<ConnectionFactoryProtocol> *) getConnectionFactory;
-(NSObject<LocationParserProtocol> *) getLocationParser;
-(NSObject<LocationReceiverProtocol> *) getLocationReceiver;
@end