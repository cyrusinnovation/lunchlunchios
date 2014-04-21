//
// Created by Cyrus on 4/18/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LunchParser.h"
#import "LunchProtocol.h"
#import "PersonParser.h"
#import "Lunch.h"
#import "NullPerson.h"


@interface LunchParser ()
- (BOOL)dictionaryHasAllKeys:(NSDictionary *)dictionary;
@end

@implementation LunchParser {

}
- (NSArray *)parseLunches:(NSData *)lunchJSONData {

    NSError *error;
    NSArray *lunchDataArray = [NSJSONSerialization
            JSONObjectWithData:lunchJSONData
                       options:0
                         error:&error];


    NSDateFormatter *dateMaker = [[NSDateFormatter alloc] init];
    [dateMaker setDateFormat:@"yyyy-dd-MM'T'HH:mm:ss.SSSZ"];

    NSMutableArray *lunches = [[NSMutableArray alloc] init];
    for (NSDictionary *lunchDictionary in lunchDataArray) {

        if ([self dictionaryHasAllKeys:lunchDictionary]) {
            PersonParser *parser = [PersonParser singleton];
            NSObject <PersonProtocol> *person1 = [parser parsePersonUsingDictionary:[lunchDictionary objectForKey:@"person1"]];
            NSObject <PersonProtocol> *person2 = [parser parsePersonUsingDictionary:[lunchDictionary objectForKey:@"person2"]];
            NSDate *date = [dateMaker dateFromString:[lunchDictionary objectForKey:@"dateTime"]];
            if (person1 != [NullPerson singleton] && person2 != [NullPerson singleton] && date != nil) {
                [lunches addObject:[[Lunch alloc] initWithPerson1:person1 person2:person2 dateTime:date]];
            }
        }
    }
    return lunches;
}

- (BOOL)dictionaryHasAllKeys:(NSDictionary *)dictionary {

    return [self hasKey:dictionary key:@"person1"] && [self hasKey:dictionary key:@"person2"] && [self hasKey:dictionary key:@"dateTime"];
}

- (BOOL)hasKey:(NSDictionary *)dictionary key:(NSString *)key {

    return [[dictionary allKeys] containsObject:key];
}

+ (LunchParser *)singleton {
    static LunchParser *SINGLETON;
    if (!SINGLETON) {
        SINGLETON = [[LunchParser alloc] init];

    }
    return SINGLETON;
}


@end