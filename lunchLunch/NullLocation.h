//
// Created by Cyrus on 5/15/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationProtocol.h"


@interface NullLocation : NSObject<LocationProtocol>
+(NullLocation*) singleton;
@end