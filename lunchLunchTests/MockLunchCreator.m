//
// Created by Cyrus on 4/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockLunchCreator.h"
#import "LunchProtocol.h"


@implementation MockLunchCreator {

    NSObject <LunchProtocol> *lunchCreated;
}
- (void)createLunch:(NSObject <LunchProtocol> *)lunch {
    lunchCreated = lunch;
}
-(NSObject<LunchProtocol>* ) getLunchCreated{
    return lunchCreated;
}

@end