//
// Created by Cyrus on 4/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LunchCreatorProtocol.h"


@interface MockLunchCreator : NSObject  <LunchCreatorProtocol>
- (NSObject <LunchProtocol> *)getLunchCreated;
@end