//
// Created by Cyrus on 4/18/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LunchProviderFactory.h"
#import "LunchProviderProtocol.h"
#import "LunchReceiverProtocol.h"
#import "LunchProvider.h"
#import "ConnectionFactory.h"
#import "LunchParser.h"
#import "PersonParser.h"


@implementation LunchProviderFactory {

}
+ (NSObject <LunchProviderProtocol> *)buildLunchProvider:(NSObject <LunchReceiverProtocol> *)lunchReceiver {
    return [[LunchProvider alloc] initWithConnectionFactory:[ConnectionFactory singleton]
                                                lunchParser:[LunchParser singleton] personParser:[PersonParser singleton] andLunchReceiver:lunchReceiver];
}

@end