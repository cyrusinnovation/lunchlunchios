//
// Created by Cyrus on 6/20/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockCLLocationManager.h"


@implementation MockCLLocationManager {

    id <CLLocationManagerDelegate> delegateSet;
    bool startUpdateLocationCalled;
    bool stopUpdatingLocationCalled;
}
- (void)setDelegate:(id <CLLocationManagerDelegate>)delegate {
    delegateSet = delegate;
}

- (void)startUpdatingLocation {
    startUpdateLocationCalled = true;
}

- (id <CLLocationManagerDelegate>)getDelegateSet {
    return delegateSet;
}

- (bool)wasUpdateLocationCalled {
    return startUpdateLocationCalled;
}

- (void)stopUpdatingLocation {
    stopUpdatingLocationCalled = true;
}

- (bool) wasStopUpdatingLocationCalled{
    return stopUpdatingLocationCalled;
}

@end