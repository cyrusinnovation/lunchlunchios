//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LunchProtocol.h"
#import "LocationProtocol.h"

@protocol LunchUpdaterProtocol <NSObject>
- (void)updateLunch:(NSObject <LunchProtocol> *)lunch withLocation:(NSObject<LocationProtocol> *) location;
@end
