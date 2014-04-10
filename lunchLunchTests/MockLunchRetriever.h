//
// Created by Cyrus on 4/9/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LunchRetrieverProtocol.h"


@interface MockLunchRetriever : NSObject <LunchRetrieverProtocol>
- (void)setAllLunchesToReturn:(NSArray *)allLunches;
@end