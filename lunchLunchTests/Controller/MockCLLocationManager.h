//
// Created by Cyrus on 6/20/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface MockCLLocationManager : CLLocationManager
- (id <CLLocationManagerDelegate>)getDelegateSet;

- (bool)wasUpdateLocationCalled;

- (bool)wasStopUpdatingLocationCalled;
@end