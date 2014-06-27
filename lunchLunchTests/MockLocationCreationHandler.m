//
// Created by Cyrus on 6/26/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockLocationCreationHandler.h"
#import "LocationProtocol.h"


@implementation MockLocationCreationHandler {

    bool locationSaveErrorCalled;
    NSObject <LocationProtocol> *locationSaved;
}
- (void)locationSaved:(NSObject <LocationProtocol> *)location {
    locationSaved = location;
}

- (void)locationSaveError {
    locationSaveErrorCalled = true;

}

- (bool)wasLocationSaveErrorCalled {
    return locationSaveErrorCalled;
}
-(NSObject<LocationProtocol> *) getLocationSaved{
    return locationSaved;
}

@end