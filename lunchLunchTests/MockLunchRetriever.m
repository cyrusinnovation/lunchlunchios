//
// Created by Cyrus on 4/9/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockLunchRetriever.h"


@implementation MockLunchRetriever {

    NSArray *allLunchesToReturn;
}
- (NSArray *)getAllLunches {
    return allLunchesToReturn;
}

- (void) setAllLunchesToReturn: (NSArray *) allLunches{
    allLunchesToReturn = allLunches;
}

@end