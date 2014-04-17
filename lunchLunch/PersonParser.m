//
// Created by Cyrus on 4/16/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "PersonParser.h"
#import "Person.h"
#import "NullPerson.h"


@interface PersonParser ()
- (BOOL)dictionaryHasAllKeys:(NSDictionary *)dictionary;

- (BOOL)hasKey:(NSDictionary *)dictionary key:(NSString *)key;
@end

@implementation PersonParser {

}
+ (PersonParser *)singleton {
    static PersonParser *SINGLETON;
    if(!SINGLETON){
        SINGLETON = [[PersonParser alloc]init];

    }
    return SINGLETON;
}

- (NSObject <PersonProtocol> *)parsePerson:(NSData *)personJsonData {
    NSError *error;
    NSDictionary *personDictionary = [NSJSONSerialization
            JSONObjectWithData:personJsonData
                       options:kNilOptions
                         error:&error];


    if ([self dictionaryHasAllKeys:personDictionary]) {
        return [[Person alloc] initWithFirstName:[personDictionary objectForKey:@"firstName"]
                                        lastName:[personDictionary objectForKey:@"lastName"]
                                           email:[personDictionary objectForKey:@"email"]];
    }
    else {
        return [NullPerson singleton];
    }
}

- (BOOL)dictionaryHasAllKeys:(NSDictionary *)dictionary {

    return [self hasKey:dictionary key:@"firstName"] && [self hasKey:dictionary key:@"lastName"] &&[self hasKey:dictionary key:@"email"] ;
}

- (BOOL)hasKey:(NSDictionary *)dictionary key:(NSString *)key {

    return [[dictionary allKeys] containsObject:key];
}



@end