//
// Created by Cyrus on 7/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "PersonCreatorFactory.h"
#import "PersonCreatorProtocol.h"
#import "PersonReceiverProtocol.h"
#import "PersonCreator.h"
#import "ConnectionFactory.h"
#import "PersonParser.h"


@implementation PersonCreatorFactory {

}
+ (NSObject <PersonCreatorProtocol> *)buildPersonCreator:(NSObject <PersonReceiverProtocol> *)personReceiver {
    return [[PersonCreator alloc] initWithConnectionFactory:[ConnectionFactory singleton]
                                               personParser:[PersonParser singleton]
                                          andPersonReceiver:personReceiver];
}

@end