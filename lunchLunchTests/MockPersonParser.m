//
// Created by Cyrus on 4/17/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "PersonParserProtocol.h"
#import "MockPersonParser.h"


@implementation MockPersonParser {
    NSData *personDataPassedIn;
    NSObject <PersonProtocol> *personToReturn;
    NSObject <PersonProtocol> *personToStringfy;
    NSString *personJSONToReturn;

}


- (NSObject <PersonProtocol> *)parsePersonUsingJsonData:(NSData *)personJsonData {
    personDataPassedIn = personJsonData;
    return personToReturn;
}

- (NSObject <PersonProtocol> *)parsePersonUsingDictionary:(NSDictionary *)personJsonDictionary {
    return nil;
}

- (NSString *)buildPersonJSONString:(NSObject <PersonProtocol> *)person {
    personToStringfy = person;

    return personJSONToReturn;
}

- (void) setPersonJSONToReturn:(NSString*) string{
    personJSONToReturn = string;
}

- (void)setPersonToReturn:(NSObject <PersonProtocol> *)person {
    personToReturn = person;
}
-(NSObject<PersonProtocol   > * ) getPersonToStringify{
    return personToStringfy;
}
- (NSData *)getPersonDataPassedIn {
    return personDataPassedIn;
}
@end