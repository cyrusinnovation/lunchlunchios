//
// Created by Cyrus on 4/17/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "PersonParserProtocol.h"
#import "MockPersonParser.h"


@implementation MockPersonParser {
    NSData *personDataPassedIn;
    NSObject <PersonProtocol> *personToReturn;
}
- (NSObject <PersonProtocol> *)parsePerson:(NSData *)personJsonData {
    personDataPassedIn = personJsonData;
    return personToReturn;
}

- (void)setPersonToReturn:(NSObject <PersonProtocol> *)person {
    personToReturn = person;
}

- (NSData *)getPersonDataPassedIn {
    return personDataPassedIn;
}
@end