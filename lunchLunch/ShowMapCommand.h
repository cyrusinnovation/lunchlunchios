//
// Created by Cyrus on 6/20/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface ShowMapCommand : NSObject<Command>
- (id)initWithLocationManager:(CLLocationManager *)manager andDelegate:(NSObject<CLLocationManagerDelegate> *)delegate;

- (CLLocationManager *)getLocationManager;

- (NSObject <CLLocationManagerDelegate> *)getLocationManagerDelegate;
@end