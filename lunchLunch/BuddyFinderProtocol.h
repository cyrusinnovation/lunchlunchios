//
// Created by Cyrus on 4/21/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonProtocol.h"


@protocol BuddyFinderProtocol <NSObject>
- (void)findBuddyFor:(NSObject<PersonProtocol> *)person;
@end