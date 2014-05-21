//
// Created by Cyrus on 4/4/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "PersonProtocol.h"
#import "LocationProtocol.h"


@protocol LunchProtocol <NSObject>
- (NSObject <PersonProtocol> *)getPerson1;

- (NSObject <PersonProtocol> *)getPerson2;

- (NSDate *)getDateAndTime;

- (NSObject <LocationProtocol> *)getLocation;
@end