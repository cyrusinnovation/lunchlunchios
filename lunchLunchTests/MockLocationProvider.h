//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationProviderProtocol.h"


@interface MockLocationProvider : NSObject<LocationProviderProtocol>
- (BOOL)wasGetAllLocationsCalled;
@end