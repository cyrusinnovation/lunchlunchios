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
    NSString *addressForFormat;
    NSString *nameForFormat;
    NSString *zipCode;
    NSData *jsonDataToReturn;
    NSObject <LocationProtocol> *parsedLocationToReturn;
    NSData *locationJSONToParse;
}
- (NSObject <LocationProtocol> *)parseLocationUsingDictionary:(NSDictionary *)dictionary {
    return nil;
}

- (NSObject <LocationProtocol> *)parseLocationUsingJsonData:(NSData *)locationJSON {
    locationJSONToParse = locationJSON;
    return parsedLocationToReturn;
}

- (NSData *)getJSONToParse {
    return locationJSONToParse;
}

- (void)setLocationToReturn:(NSObject <LocationProtocol> *)location {
    parsedLocationToReturn = location;
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

- (NSData *)formatJSONWithName:(NSString *)name withAddress:(NSString *)address andZipCode:(NSString *)code {
    nameForFormat = name;
    addressForFormat = address;
    zipCode = code;

    return jsonDataToReturn;
}

- (void)setJSONDataToReturn:(NSData *)data {
    jsonDataToReturn = data;
}

- (NSString *)getNameForFormat {
    return nameForFormat;
}

- (NSString *)getAddressForFormat {
    return addressForFormat;
}

- (NSString *)getZipCodeForFormat {
    return zipCode;
}
@end