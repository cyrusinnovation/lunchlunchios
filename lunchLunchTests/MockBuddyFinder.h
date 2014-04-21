//
// Created by Cyrus on 4/21/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BuddyFinderProtocol.h"


@interface MockBuddyFinder : NSObject  <BuddyFinderProtocol>
-(NSObject<PersonProtocol>*) getPersonUsedToFindBuddy;
@end