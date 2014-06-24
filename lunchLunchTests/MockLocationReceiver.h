//
// Created by Cyrus on 6/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationReceiverProtocol.h"


@interface MockLocationReceiver : NSObject<LocationReceiverProtocol>
- (NSArray *)getLocationsFound;
@end