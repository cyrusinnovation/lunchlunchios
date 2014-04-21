//
// Created by Cyrus on 4/18/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LunchParser.h"
#import "LunchParserProtocol.h"
#import "Person.h"
#import "PersonParser.h"
#import "Lunch.h"

@interface LunchParserTest : XCTestCase
@end

@interface LunchParserTest ()
- (NSDictionary *)buildPersonDictionary:(Person *)person;
@end

@implementation LunchParserTest {

}
- (void)testIsOfCorrectProtocol {
    XCTAssertTrue([LunchParser conformsToProtocol:@protocol(LunchParserProtocol)]);
}

- (void)testSingleton {

    XCTAssertNotNil([LunchParser singleton]);
    XCTAssertEqual([LunchParser singleton], [LunchParser singleton]);
}

- (void)testParseLunches {


    Person *expectedPerson1 = [[Person alloc] initWithFirstNameInitWithId:@"2t23f" firstName:@"Jimmy" lastName:@"Jazz" email:@"jimjazz@gmail.com"];
    Person *expectedPerson2 = [[Person alloc] initWithFirstNameInitWithId:@"dfsgg" firstName:@"Janie" lastName:@"Jones" email:@"janiej@yahoo.com"];
    Person *expectedPerson3 = [[Person alloc] initWithFirstNameInitWithId:@"3253" firstName:@"Sean" lastName:@"Flynn" email:@"sflynn@prodigy.net"];

    NSDictionary *person1Dictionary = [self buildPersonDictionary:expectedPerson1];
    NSDictionary *person2Dictionary = [self buildPersonDictionary:expectedPerson2];
    NSDictionary *person3Dictionary = [self buildPersonDictionary:expectedPerson3];

    NSString *dateString1 = @"2017-11-07T12:30:00.000Z";
    NSDictionary *lunch1Dictionary = [NSDictionary dictionaryWithObjectsAndKeys:person1Dictionary, @"person1", person2Dictionary, @"person2", dateString1, @"dateTime", nil];
    NSString *dateString2 = @"2017-11-05T13:00:00.000Z";
    NSDictionary *lunch2Dictionary = [NSDictionary dictionaryWithObjectsAndKeys:person3Dictionary, @"person1", person2Dictionary, @"person2", dateString2, @"dateTime", nil];
    NSString *dateString3 = @"2017-12-01T20:00:00.000Z";
    NSDictionary *lunch3Dictionary = [NSDictionary dictionaryWithObjectsAndKeys:person3Dictionary, @"person1", person1Dictionary, @"person2", dateString3, @"dateTime", nil];

    NSArray *arrayOfLunchDictionaries = [NSArray arrayWithObjects:lunch1Dictionary, lunch2Dictionary, lunch3Dictionary, nil];

    NSData *data = [NSJSONSerialization dataWithJSONObject:arrayOfLunchDictionaries options:NSJSONWritingPrettyPrinted error:nil];
    NSArray *allLunches = [[LunchParser singleton] parseLunches:data];
    XCTAssertEqual(3, [allLunches count]);
    [self checkLunchAtIndex:expectedPerson1 expectedPerson2:expectedPerson2 dateString:dateString1 allLunches:allLunches index:0];
    [self checkLunchAtIndex:expectedPerson3 expectedPerson2:expectedPerson2 dateString:dateString2 allLunches:allLunches index:1];
    [self checkLunchAtIndex:expectedPerson3 expectedPerson2:expectedPerson1 dateString:dateString3 allLunches:allLunches index:2];

}

- (NSDictionary *)buildPersonDictionary:(Person *)person {
    return [NSDictionary dictionaryWithObjectsAndKeys:[person getId], @"_id", [person getFirstName], @"firstName", [person getLastName], @"lastName", [person getEmailAddress], @"email", nil ];
}

- (void)testParseLunches_WillIgnoreAnyIncompleteLunchEntries {


    Person *person1 = [[Person alloc] initWithFirstNameInitWithId:@"adsa" firstName:@"Jimmy" lastName:@"Jazz" email:@"jimjazz@gmail.com"];
    Person *person2 = [[Person alloc] initWithFirstNameInitWithId:@"t635" firstName:@"Janie" lastName:@"Jones" email:@"janiej@yahoo.com"];

    NSDictionary *person1Dictionary = [self buildPersonDictionary:person1];
    NSDictionary *person2Dictionary = [self buildPersonDictionary:person2];

    NSDictionary *personMissingFirstName = [NSDictionary dictionaryWithObjectsAndKeys:@"Yo", @"lastName", @"Bobobob@mal.com", @"email", @"432", @"_id", nil];
    NSDictionary *personMissingLastName = [NSDictionary dictionaryWithObjectsAndKeys:@"Joe", @"firstName", @"Bobobob@mal.com", @"email", @"432", @"_id", nil];
    NSDictionary *personMissingEmail = [NSDictionary dictionaryWithObjectsAndKeys:@"Jobra", @"firstName", @"Smith", @"lastName", @"432", @"_id", nil];
    NSDictionary *personMissingId = [NSDictionary dictionaryWithObjectsAndKeys:@"Jobra", @"firstName", @"Smith", @"lastName", @"email@mcgee.com", @"email", nil];

    NSString *dateString1 = @"2017-11-07T12:30:00.000Z";
    NSDictionary *goodLunchDictionary = [NSDictionary dictionaryWithObjectsAndKeys:person1Dictionary, @"person1", person2Dictionary, @"person2", dateString1, @"dateTime", nil];
    NSDictionary *noFirstNameDictionary = [NSDictionary dictionaryWithObjectsAndKeys:person1Dictionary, @"person1", personMissingFirstName, @"person2", dateString1, @"dateTime", nil];
    NSDictionary *noLastNameDictionary = [NSDictionary dictionaryWithObjectsAndKeys:person1Dictionary, @"person1", personMissingLastName, @"person2", dateString1, @"dateTime", nil];
    NSDictionary *noEmailDictionary = [NSDictionary dictionaryWithObjectsAndKeys:person1Dictionary, @"person1", personMissingEmail, @"person2", dateString1, @"dateTime", nil];
    NSDictionary *noIdDictionary = [NSDictionary dictionaryWithObjectsAndKeys:person1Dictionary, @"person1", personMissingId, @"person2", dateString1, @"dateTime", nil];
    NSDictionary *badDateFormatDictionary = [NSDictionary dictionaryWithObjectsAndKeys:person1Dictionary, @"person1", person2Dictionary, @"person2", @"thiswillnotbeadatetime", @"dateTime", nil];

    NSDictionary *noPerson1Dictionary = [NSDictionary dictionaryWithObjectsAndKeys:person2Dictionary, @"person2", dateString1, @"dateTime", nil];
    NSDictionary *noPerson2Dictionary = [NSDictionary dictionaryWithObjectsAndKeys:person1Dictionary, @"person1", dateString1, @"dateTime", nil];
    NSDictionary *noDateTimeDictionary = [NSDictionary dictionaryWithObjectsAndKeys:person1Dictionary, @"person1", person2Dictionary, @"person2", nil];


    NSArray *arrayOfLunchDictionaries = [NSArray arrayWithObjects:goodLunchDictionary, noFirstNameDictionary, noLastNameDictionary,
                                                                  noEmailDictionary, badDateFormatDictionary,noIdDictionary, noPerson1Dictionary,
                                                                  noPerson2Dictionary, noDateTimeDictionary, nil];

    NSData *data = [NSJSONSerialization dataWithJSONObject:arrayOfLunchDictionaries options:NSJSONWritingPrettyPrinted error:nil];
    NSArray *allLunches = [[LunchParser singleton] parseLunches:data];
    XCTAssertEqual(1, [allLunches count]);
    [self checkLunchAtIndex:person1 expectedPerson2:person2 dateString:dateString1 allLunches:allLunches index:0];


}


- (void)checkLunchAtIndex:(Person *)expectedPerson1 expectedPerson2:(Person *)expectedPerson2 dateString:(NSString *)dateString allLunches:(NSArray *)allLunches index:(int)index {
    XCTAssertTrue([allLunches[index] isKindOfClass:[Lunch class]]);
    Lunch *lunch = (Lunch *) allLunches[index];

    NSDateFormatter *dateMaker = [[NSDateFormatter alloc] init];
    [dateMaker setDateFormat:@"yyyy-dd-MM'T'HH:mm:ss.SSSZ"];
    XCTAssertEqualObjects(expectedPerson1, [lunch getPerson1]);
    XCTAssertEqualObjects(expectedPerson2, [lunch getPerson2]);
    XCTAssertEqualObjects([dateMaker dateFromString:dateString], [lunch getDateAndTime]);
}


@end