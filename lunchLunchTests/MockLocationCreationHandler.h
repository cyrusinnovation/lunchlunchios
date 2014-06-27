//
// Created by Cyrus on 6/26/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationCreationHandler.h"


@interface MockLocationCreationHandler : NSObject<LocationCreationHandler>
- (bool)wasLocationSaveErrorCalled;

- (NSObject <LocationProtocol> *)getLocationSaved;
@end