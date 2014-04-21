//
// Created by Cyrus on 4/18/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockLunchProvider.h"


@implementation MockLunchProvider {

    NSObject <PersonProtocol> *personToFindLunchesFor;
}
- (void)findLunchesFor:(NSObject <PersonProtocol> *)person {
    personToFindLunchesFor = person;

}
-(NSObject<PersonProtocol> *) getPersonToFindLunchesFor{
    return personToFindLunchesFor;
}

@end