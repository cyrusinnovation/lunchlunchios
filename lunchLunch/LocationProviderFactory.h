//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationProviderProtocol.h"

@protocol LocationReceiverProtocol;


@interface LocationProviderFactory : NSObject
+(NSObject<LocationProviderProtocol> *) buildLocationProvider : (NSObject<LocationReceiverProtocol> *) locationReceiver;
@end