//
// Created by Cyrus on 4/16/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "PersonParser.h"
#import "Person.h"
#import "NullPerson.h"


@interface PersonParser ()
- (NSObject <PersonProtocol> *)processPersonDictionary:(NSDictionary *)personDictionary;

- (BOOL)dictionaryHasAllKeys:(NSDictionary *)dictionary;

- (BOOL)hasKey:(NSDictionary *)dictionary key:(NSString *)key;
@end

@implementation PersonParser {

}
+ (PersonParser *)singleton {
    static PersonParser *SINGLETON;
    if (!SINGLETON) {
        SINGLETON = [[PersonParser alloc] init];

    }
    return SINGLETON;
}

- (NSObject <PersonProtocol> *)parsePersonUsingJsonData:(NSData *)personJsonData {
    NSError *error;
    NSDictionary *personDictionary = [NSJSONSerialization
            JSONObjectWithData:personJsonData
                       options:0
                         error:&error];


    return [self processPersonDictionary:personDictionary];
}


- (NSObject <PersonProtocol> *)parsePersonUsingDictionary:(NSDictionary *)personJsonDictionary {
    return [self processPersonDictionary:personJsonDictionary];
}


- (NSString *)buildPersonJSONString:(NSObject <PersonProtocol> *)person {
    NSError *error;
    NSDictionary *personDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[person getFirstName], @"firstName",
                                                                                [person getLastName], @"lastName",
                                                                                [person getEmailAddress], @"email",
                                                                                [person getId], @"_id", nil];

    NSData *personData = [NSJSONSerialization dataWithJSONObject:personDictionary options:0 error:&error];

    return [[NSString alloc] initWithData:personData encoding:NSUTF8StringEncoding];
}


- (NSObject <PersonProtocol> *)processPersonDictionary:(NSDictionary *)personDictionary {
    if ([self dictionaryHasAllKeys:personDictionary]) {
        return [[Person alloc] initWithFirstNameInitWithId:[personDictionary objectForKey:@"_id"]
                                                 firstName:[personDictionary objectForKey:@"firstName"]
                                                  lastName:[personDictionary objectForKey:@"lastName"]
                                                     email:[personDictionary objectForKey:@"email"]];
    }
    else {
        return [NullPerson singleton];
    }
}

- (BOOL)dictionaryHasAllKeys:(NSDictionary *)dictionary {

    return [self hasKey:dictionary key:@"firstName"] && [self hasKey:dictionary key:@"lastName"] && [self hasKey:dictionary key:@"email"] && [self hasKey:dictionary key:@"_id"];
}

- (BOOL)hasKey:(NSDictionary *)dictionary key:(NSString *)key {

    return [[dictionary allKeys] containsObject:key];
}

@end