//
// Created by Cyrus on 6/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationProtocol.h"


@protocol LocationParserProtocol <NSObject>
- (NSObject <LocationProtocol> *)parseLocationUsingDictionary:(NSDictionary *)dictionary;

- (NSObject <LocationProtocol> *)parseLocationUsingJsonData:(NSData *)locationJSON;

- (NSArray *)parseLocationList:(NSData *)locationData;

- (NSData *)formatJSONWithName:(NSString *)name withAddress:(NSString *)address andZipCode:(NSString *)code;

@end