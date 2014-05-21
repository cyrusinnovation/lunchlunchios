//
// Created by Cyrus on 5/20/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationProtocol.h"

@interface LocationParser : NSObject
+ (LocationParser *)singleton;

- (NSObject <LocationProtocol> *)parseLocationUsingDictionary:(NSDictionary *)dictionary;
@end