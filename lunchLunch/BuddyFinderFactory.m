//
// Created by Cyrus on 4/21/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "BuddyFinderFactory.h"
#import "BuddyFinderProtocol.h"
#import "PersonReceiverProtocol.h"
#import "BuddyFinder.h"
#import "ConnectionFactory.h"
#import "PersonParser.h"


@implementation BuddyFinderFactory {

}
+ (NSObject <BuddyFinderProtocol> *)buildBuddyFinder:(NSObject <PersonReceiverProtocol> *)personReceiver {
    return [[BuddyFinder alloc] initWithConnectionFactory:[ConnectionFactory singleton]personParser:[PersonParser singleton] andPersonReceiver:personReceiver];
}

@end