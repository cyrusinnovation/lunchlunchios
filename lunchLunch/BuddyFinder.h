//
// Created by Cyrus on 4/21/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BuddyFinderProtocol.h"
#import "PersonParserProtocol.h"
#import "PersonReceiverProtocol.h"
#import "ConnectionFactoryProtocol.h"


@interface BuddyFinder : NSObject<NSURLConnectionDataDelegate, BuddyFinderProtocol>

- (id)initWithConnectionFactory:(NSObject <ConnectionFactoryProtocol> *)factory personParser:(NSObject <PersonParserProtocol> *)parser andPersonReceiver:(NSObject <PersonReceiverProtocol> *)receiver;
-(NSObject<PersonReceiverProtocol> *)getPersonReceiver;
-(NSObject<ConnectionFactoryProtocol> *)getConnectionFactory;
-(NSObject<PersonParserProtocol> *)getPersonParser;
@end