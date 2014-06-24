//
// Created by Cyrus on 6/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockLocationParser.h"


@implementation MockLocationParser {

    NSArray *locationsToReturn;
    NSData *locationDataPassedIn;
}
- (NSObject <LocationProtocol> *)parseLocationUsingDictionary:(NSDictionary *)dictionary {
    return nil;
}

- (NSArray *)parseLocationList:(NSData *)locationData {
    locationDataPassedIn = locationData;
    return locationsToReturn;
}

- (NSData *)getLocationDataPassedIn {
    return locationDataPassedIn;
}

- (void)setLocationsToReturn:(NSArray *)locations {
    locationsToReturn = locations;
}


@end