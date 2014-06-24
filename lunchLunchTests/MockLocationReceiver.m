//
// Created by Cyrus on 6/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockLocationReceiver.h"


@implementation MockLocationReceiver {

    NSArray *locationsFound;
}
- (void)handleLocationsFound:(NSArray *)locations {
    locationsFound = locations;
}

- (NSArray *)getLocationsFound {
    return locationsFound;
}
@end