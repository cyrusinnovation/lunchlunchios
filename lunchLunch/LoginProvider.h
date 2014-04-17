//
// Created by Cyrus on 4/2/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonProtocol.h"
#import "ConnectionFactoryProtocol.h"

#import "PersonReceiverProtocol.h"
#import "PersonParserProtocol.h"
#import "LoginProviderProtocol.h"


@interface LoginProvider : NSObject<NSURLConnectionDataDelegate, LoginProviderProtocol> {
    NSObject <ConnectionFactoryProtocol> *connectionFactory;
    NSObject<PersonReceiverProtocol>* receiver;
    NSObject<PersonParserProtocol> * parser;
}

- (id)initWithConnectionFactory:(NSObject <ConnectionFactoryProtocol> *)factory personParser:(NSObject <PersonParserProtocol>*) parser andPersonReceiver:(NSObject<PersonReceiverProtocol>*) personReceiver;

- (NSObject <ConnectionFactoryProtocol> *)getConnectionFactory;

- (NSObject <PersonParserProtocol> *)getPersonParser;

- (NSObject <PersonReceiverProtocol> *)getPersonReceiver;

- (void)findPersonByEmail:(NSString *)email;

@end