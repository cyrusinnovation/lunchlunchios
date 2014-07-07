//
// Created by Cyrus on 4/17/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "PersonParserProtocol.h"
#import "MockPersonParser.h"


@implementation MockPersonParser {
    NSData *personDataPassedIn;
    NSObject <PersonProtocol> *personToReturn;
    NSObject <PersonProtocol> *personToJsonify;
    NSData *personJSONToReturn;

    NSString *firstNameForBuild;
    NSString *lastNameForBuild;
    NSString *emailForBuild;
}


- (NSObject <PersonProtocol> *)parsePersonUsingJsonData:(NSData *)personJsonData {
    personDataPassedIn = personJsonData;
    return personToReturn;
}

- (NSObject <PersonProtocol> *)parsePersonUsingDictionary:(NSDictionary *)personJsonDictionary {
    return nil;
}

- (NSData *)buildPersonJSONData:(NSObject <PersonProtocol> *)person {
    personToJsonify = person;

    return personJSONToReturn;
}

- (NSData *)buildPersonJSONWithFirstName:(NSString *)firstName lastName:(NSString *)lastName emailAddress:(NSString *)email {
    firstNameForBuild = firstName;
    lastNameForBuild = lastName;
    emailForBuild = email;
    return personJSONToReturn;
}
-(NSString *)getFirstNameForBuild{
    return firstNameForBuild;
}
-(NSString *)getLastNameForBuild{
    return lastNameForBuild;
}
-(NSString *)getEmailForBuild{
    return emailForBuild;
}


- (void)setPersonJSONToReturn:(NSData *)string {
    personJSONToReturn = string;
}

- (void)setPersonToReturn:(NSObject <PersonProtocol> *)person {
    personToReturn = person;
}

- (NSObject <PersonProtocol> *)getPersonToJSONify {
    return personToJsonify;
}

- (NSData *)getPersonDataPassedIn {
    return personDataPassedIn;
}
@end