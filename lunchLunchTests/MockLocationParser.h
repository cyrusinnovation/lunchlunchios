//
// Created by Cyrus on 6/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationParserProtocol.h"


@interface MockLocationParser : NSObject<LocationParserProtocol>
- (NSObject <LocationProtocol> *)getLocationForBuildJSONData;

- (void)setLocationDataToReturn:(NSData *)dataToReturn;

- (NSData *)getLocationDataPassedIn;

-(void) setLocationsToReturn:(NSArray *)locations;
@end