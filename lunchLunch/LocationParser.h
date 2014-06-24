//
// Created by Cyrus on 5/20/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationProtocol.h"
#import "LocationParserProtocol.h"

@interface LocationParser : NSObject <LocationParserProtocol>
+ (LocationParser *)singleton;


@end