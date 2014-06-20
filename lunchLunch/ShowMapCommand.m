//
// Created by Cyrus on 6/20/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "Command.h"
#import "ShowMapCommand.h"


@implementation ShowMapCommand {

    NSObject <CLLocationManagerDelegate> *locationManagerDelegate;
    CLLocationManager *locationManager;
}


- (id)initWithLocationManager:(CLLocationManager *)manager andDelegate:(NSObject<CLLocationManagerDelegate> *)delegate {
    self = [super init];
    if(self){
        locationManager = manager;
        locationManagerDelegate = delegate;
    }
    return self;
}

-(CLLocationManager *)getLocationManager{
    return locationManager;
}

-(NSObject<CLLocationManagerDelegate>*) getLocationManagerDelegate{
    return locationManagerDelegate;
}

- (void)execute {
    locationManager.delegate = locationManagerDelegate;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    [locationManager startUpdatingLocation];
}

@end