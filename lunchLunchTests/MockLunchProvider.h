//
// Created by Cyrus on 4/18/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LunchProviderProtocol.h"


@interface MockLunchProvider : NSObject<LunchProviderProtocol>
- (NSObject <PersonProtocol> *)getPersonToFindLunchesFor;
@end