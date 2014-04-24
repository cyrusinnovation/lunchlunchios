//
// Created by Cyrus on 4/18/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockLunchParser.h"


@implementation MockLunchParser {

    NSArray *lunchesToReturn;
    NSData *lunchDataPassedIn;
    NSData *lunchDataToReturn;
    NSObject <LunchProtocol> *lunchPassedToBuildJsonData;
}
- (NSArray *)parseLunches:(NSData *)lunchJSONData {
    lunchDataPassedIn = lunchJSONData;
    return lunchesToReturn;
}

- (NSData *)buildLunchJSONData:(NSObject <LunchProtocol> *)lunch {
    lunchPassedToBuildJsonData = lunch;
    return lunchDataToReturn;
}
-(void) setLunchDataToReturn:(NSData *) data{
    lunchDataToReturn = data;
}
-(NSObject<LunchProtocol> *) getLunchPassedToBuildJSON{
    return lunchPassedToBuildJsonData;
}


-(void) setLunchesToReturn:(NSArray*) lunches{
    lunchesToReturn = lunches;
}
-(NSData*) getLunchDataPassedIn{
    return lunchDataPassedIn;
}

@end