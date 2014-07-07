//
// Created by Cyrus on 4/18/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockLunchReceiver.h"


@implementation MockLunchReceiver {

    NSArray *lunchesReceived;
}
- (void)handleLunchesFound:(NSArray *)lunches {
    lunchesReceived = lunches;
}

-(NSArray*) getLunchesReceived{
    return lunchesReceived;
}
@end
