//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockLocationProvider.h"


@implementation MockLocationProvider {

    bool getAllLocationsCalled;
}
- (void)getAllLocations {
    getAllLocationsCalled = true;
}

- (BOOL)wasGetAllLocationsCalled {
    return getAllLocationsCalled;
}
@end