//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LunchUpdaterProtocol.h"


@interface MockLunchUpdater : NSObject <LunchUpdaterProtocol>
- (NSObject <LocationProtocol> *)getLocationForUpdate;

- (NSObject <LunchProtocol> *)getLunchForUpdate;
@end