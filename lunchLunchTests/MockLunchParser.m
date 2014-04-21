//
// Created by Cyrus on 4/18/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockLunchParser.h"


@implementation MockLunchParser {

    NSArray *lunchesToReturn;
    NSData *lunchDataPassedIn;
}
- (NSArray *)parseLunches:(NSData *)lunchJSONData {
    lunchDataPassedIn = lunchJSONData;
    return lunchesToReturn;
}

-(void) setLunchesToReturn:(NSArray*) lunches{
    lunchesToReturn = lunches;
}
-(NSData*) getLunchDataPassedIn{
    return lunchDataPassedIn;
}

@end