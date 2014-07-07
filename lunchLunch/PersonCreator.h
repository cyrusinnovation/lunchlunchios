//
// Created by Cyrus on 7/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonCreatorProtocol.h"
#import "ConnectionFactoryProtocol.h"
#import "PersonParserProtocol.h"
#import "PersonReceiverProtocol.h"

@interface PersonCreator : NSObject <NSURLConnectionDataDelegate, PersonCreatorProtocol>
- (id)initWithConnectionFactory:(NSObject <ConnectionFactoryProtocol> *)factory personParser:(NSObject <PersonParserProtocol> *)parser andPersonReceiver:(NSObject <PersonReceiverProtocol> *)receiver;

- (NSObject <ConnectionFactoryProtocol> *)getConnectionFactory;

- (NSObject <PersonParserProtocol> *)getPersonParser;

- (NSObject <PersonReceiverProtocol> *)getPersonReceiver;
@end