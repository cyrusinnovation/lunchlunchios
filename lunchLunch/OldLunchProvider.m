//
// Created by Cyrus on 4/9/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "OldLunchProvider.h"
#import "PersonProtocol.h"


@interface OldLunchProvider ()
@end

@implementation OldLunchProvider {

    NSObject <LunchRetrieverProtocol> *lunchRetriever;
}
- (id)initWithLunchRetriever:(NSObject <LunchRetrieverProtocol> *)retriever {
    self = [super init];
    if (self){
        lunchRetriever = retriever;        
    }
    return self;
}

- (NSArray *)findLunchesFor:(NSObject <PersonProtocol> *)person {
    NSArray *allLunches = lunchRetriever.getAllLunches;
    NSMutableArray * lunchesForPerson = [[NSMutableArray alloc] init];
    for(NSObject<LunchProtocol>* lunch in allLunches){
        if([[lunch getPerson1] isEqual:person] || [[lunch getPerson2] isEqual:person]){
            [lunchesForPerson addObject:lunch];
        }
    }
    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"dateTime" ascending:YES];

  [lunchesForPerson sortUsingDescriptors:@[sd]];
    return lunchesForPerson;
}


@end