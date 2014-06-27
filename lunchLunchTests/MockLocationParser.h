//
// Created by Cyrus on 6/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationParserProtocol.h"


@interface MockLocationParser : NSObject<LocationParserProtocol>
- (NSData *)getJSONToParse;

- (void)setLocationToReturn:(NSObject <LocationProtocol> *)location;

- (NSObject <LocationProtocol> *)getLocationForBuildJSONData;

- (void)setLocationDataToReturn:(NSData *)dataToReturn;

- (NSData *)getLocationDataPassedIn;

-(void) setLocationsToReturn:(NSArray *)locations;

- (void)setJSONDataToReturn:(NSData *)data;

- (NSString *)getNameForFormat;

- (NSString *)getAddressForFormat;

- (NSString *)getZipCodeForFormat;
@end