//
// Created by Cyrus on 4/17/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LoginProviderFactory.h"
#import "LoginProviderProtocol.h"
#import "PersonReceiverProtocol.h"
#import "LoginProvider.h"
#import "ConnectionFactory.h"
#import "PersonParser.h"


@implementation LoginProviderFactory {

}

+ (NSObject <LoginProviderProtocol> *)buildLoginProvider:(NSObject<PersonReceiverProtocol> *) personReceiver {
    return [[LoginProvider alloc] initWithConnectionFactory:[ConnectionFactory singleton] personParser:[PersonParser singleton] andPersonReceiver:personReceiver];
}


@end