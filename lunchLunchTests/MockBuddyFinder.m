//
// Created by Cyrus on 4/21/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockBuddyFinder.h"


@implementation MockBuddyFinder {

    NSObject <PersonProtocol> *personUsedToFindBuddy;
}
- (void)findBuddyFor:(NSObject <PersonProtocol> *)person {
    personUsedToFindBuddy = person;

}

- (NSObject <PersonProtocol> *)getPersonUsedToFindBuddy {
    return personUsedToFindBuddy;
}


@end