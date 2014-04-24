//
// Created by Cyrus on 4/18/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LunchParserProtocol.h"


@interface MockLunchParser : NSObject    <LunchParserProtocol>
- (void)setLunchDataToReturn:(NSData *)data;

- (NSObject <LunchProtocol> *)getLunchPassedToBuildJSON;

- (void)setLunchesToReturn:(NSArray *)lunches;

- (NSData *)getLunchDataPassedIn;
@end