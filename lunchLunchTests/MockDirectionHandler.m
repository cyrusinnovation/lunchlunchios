//
// Created by Cyrus on 6/19/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>
#import "MockDirectionHandler.h"


@implementation MockDirectionHandler {

}
@synthesize handleDirectionFailedCalled;

- (void)handleDirectionsReceived:(GMSPath *)path {

}

- (void)handleDirectionFailed {
    handleDirectionFailedCalled = true;

}

@end