//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LocationProviderFactory.h"
#import "LocationParserProtocol.h"
#import "LocationProviderProtocol.h"
#import "LocationReceiverProtocol.h"
#import "LocationProvider.h"
#import "ConnectionFactory.h"
#import "LocationParser.h"


@implementation LocationProviderFactory {

}
+ (NSObject <LocationProviderProtocol> *)buildLocationProvider:(NSObject <LocationReceiverProtocol> *)locationReceiver {
    return [[LocationProvider alloc] initWithConnectionFactory:[ConnectionFactory singleton]
                                                        parser:[LocationParser singleton]
                                           andLocationReceiver:locationReceiver];
}


@end