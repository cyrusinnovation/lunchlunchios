//
// Created by Cyrus on 4/18/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LunchProviderProtocol.h"
#import "ConnectionFactoryProtocol.h"
#import "LunchParserProtocol.h"
#import "PersonParserProtocol.h"
#import "LunchReceiverProtocol.h"

@interface LunchProvider : NSObject<LunchProviderProtocol, NSURLConnectionDataDelegate>
- (id)initWithConnectionFactory:(NSObject <ConnectionFactoryProtocol> *)factory lunchParser:(NSObject <LunchParserProtocol> *)parser personParser:(NSObject <PersonParserProtocol> *)parser1 andLunchReceiver:(NSObject <LunchReceiverProtocol> *)receiver;
-(NSObject<ConnectionFactoryProtocol> *) getConnectionFactory;
-(NSObject<LunchParserProtocol> *) getLunchParser;
-(NSObject<PersonParserProtocol> *) getPersonParser;
-(NSObject<LunchReceiverProtocol> *) getLunchReceiver;
@end