//
// Created by Cyrus on 5/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationProtocol.h"
#import <CoreLocation/CoreLocation.h>

@protocol DirectionsProviderProtocol <NSObject>
-(void) findDirectionsTo: (NSObject<LocationProtocol> *) location fromOrigin:(CLLocation*) origin;
@end