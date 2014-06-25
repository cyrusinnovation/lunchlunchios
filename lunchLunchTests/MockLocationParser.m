//
// Created by Cyrus on 6/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockLocationParser.h"


@implementation MockLocationParser {

    NSArray *locationsToReturn;
    NSData *locationDataPassedIn;
    NSData *locationDataToReturn;
    NSObject <LocationProtocol> *locationForBuildJSONData;
}
- (NSObject <LocationProtocol> *)parseLocationUsingDictionary:(NSDictionary *)dictionary {
    return nil;
}

- (NSArray *)parseLocationList:(NSData *)locationData {
    locationDataPassedIn = locationData;
    return locationsToReturn;
}

- (NSData *)buildLocationJSONData:(NSObject <LocationProtocol> *)location {
    locationForBuildJSONData = location;
    return locationDataToReturn;
}

- (NSObject <LocationProtocol> *)getLocationForBuildJSONData {
    return locationForBuildJSONData;
}

- (void)setLocationDataToReturn:(NSData *)dataToReturn {
    locationDataToReturn = dataToReturn;
}

- (NSData *)getLocationDataPassedIn {
    return locationDataPassedIn;
}

- (void)setLocationsToReturn:(NSArray *)locations {
    locationsToReturn = locations;
}


@end