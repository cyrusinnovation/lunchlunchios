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
#import "Location.h"
#import "NullLocation.h"

@interface LunchParserTest : XCTestCase
@end

@interface LunchParserTest ()
- (NSDictionary *)buildPersonDictionary:(Person *)person;
@end

@implementation LunchParserTest {

}
- (void)testIsOfCorrectProtocol {
    XCTAssertTrue([LunchParser conformsToProtocol:@ protocol(LunchParserProtocol)]);
}

- (void)testSingleton {

    XCTAssertNotNil([LunchParser singleton]);
    XCTAssertEqual([LunchParser singleton], [LunchParser singleton]);
}

- (void)testParseLunches {


    Person *expectedPerson1 = [[Person alloc] initWithId:@"2t23f" firstName:@"Jimmy" lastName:@"Jazz" email:@"jimjazz@gmail.com"];
    Person *expectedPerson2 = [[Person alloc] initWithId:@"dfsgg" firstName:@"Janie" lastName:@"Jones" email:@"janiej@yahoo.com"];
    Person *expectedPerson3 = [[Person alloc] initWithId:@"3253" firstName:@"Sean" lastName:@"Flynn" email:@"sflynn@prodigy.net"];
    Location *expectedLocation1 = [[Location alloc] initWithName:@"Ashley's" address:@"338 S State St" andZipCode:@"48104"];
    Location *expectedLocation2 = [[Location alloc] initWithName:@"Kosmos" address:@"407 N 5th Ave" andZipCode:@"48104"];

    NSDictionary *locationDictionary1 = [self buildLocationDictionary:expectedLocation1];
    NSDictionary *locationDictionary2 = [self buildLocationDictionary:expectedLocation2];

    NSDictionary *person1Dictionary = [self buildPersonDictionary:expectedPerson1];
    NSDictionary *person2Dictionary = [self buildPersonDictionary:expectedPerson2];
    NSDictionary *person3Dictionary = [self buildPersonDictionary:expectedPerson3];

    NSString *dateString1 = @"2017-11-07T12:30:00.000Z";
    NSDictionary *lunch1Dictionary = [NSDictionary dictionaryWithObjectsAndKeys:person1Dictionary, @"person1", person2Dictionary, @"person2", dateString1, @"dateTime", locationDictionary2, @"location", nil];
    NSString *dateString2 = @"2017-11-05T13:00:00.000Z";
    NSDictionary *lunch2Dictionary = [NSDictionary dictionaryWithObjectsAndKeys:person3Dictionary, @"person1", person2Dictionary, @"person2", dateString2, @"dateTime", locationDictionary1, @"location", nil];
    NSString *dateString3 = @"2017-12-01T20:00:00.000Z";
    NSDictionary *lunch3Dictionary = [NSDictionary dictionaryWithObjectsAndKeys:person3Dictionary, @"person1", person1Dictionary, @"person2", dateString3, @"dateTime", locationDictionary2, @"location", nil];

    NSArray *arrayOfLunchDictionaries = [NSArray arrayWithObjects:lunch1Dictionary, lunch2Dictionary, lunch3Dictionary, nil];

    NSData *data = [NSJSONSerialization dataWithJSONObject:arrayOfLunchDictionaries options:NSJSONWritingPrettyPrinted error:nil];
    NSArray *allLunches = [[LunchParser singleton] parseLunches:data];
    XCTAssertEqual(3, [allLunches count]);
    [self checkLunchAtIndex:expectedPerson1 expectedPerson2:expectedPerson2 dateString:dateString1 location:expectedLocation2 allLunches:allLunches index:0];
    [self checkLunchAtIndex:expectedPerson3 expectedPerson2:expectedPerson2 dateString:dateString2 location:expectedLocation1 allLunches:allLunches index:1];
    [self checkLunchAtIndex:expectedPerson3 expectedPerson2:expectedPerson1 dateString:dateString3 location:expectedLocation2 allLunches:allLunches index:2];

}

- (void)testParseLunches_WillIgnoreAnyIncompleteLunchEntries {


    Person *person1 = [[Person alloc] initWithId:@"adsa" firstName:@"Jimmy" lastName:@"Jazz" email:@"jimjazz@gmail.com"];
    Person *person2 = [[Person alloc] initWithId:@"t635" firstName:@"Janie" lastName:@"Jones" email:@"janiej@yahoo.com"];

    NSDictionary *person1Dictionary = [self buildPersonDictionary:person1];
    NSDictionary *person2Dictionary = [self buildPersonDictionary:person2];

    Location *expectedLocation = [[Location alloc] initWithName:@"Ashley's" address:@"338 S State St" andZipCode:@"48104"];

    NSDictionary *locationDictionary = [self buildLocationDictionary:expectedLocation];

    NSString *dateString1 = @"2017-11-07T12:30:00.000Z";
    NSDictionary *goodLunchDictionary = [NSDictionary dictionaryWithObjectsAndKeys:person1Dictionary, @"person1", person2Dictionary, @"person2", dateString1, @"dateTime", locationDictionary, @"location", nil];

    NSDictionary *noPerson1Dictionary = [NSDictionary dictionaryWithObjectsAndKeys:person2Dictionary, @"person2", dateString1, @"dateTime", locationDictionary, @"location", nil];
    NSDictionary *noPerson2Dictionary = [NSDictionary dictionaryWithObjectsAndKeys:person1Dictionary, @"person1", dateString1, @"dateTime", locationDictionary, @"location", nil];
    NSDictionary *noDateTimeDictionary = [NSDictionary dictionaryWithObjectsAndKeys:person1Dictionary, @"person1", person2Dictionary, @"person2", locationDictionary, @"location", nil];


    NSArray *arrayOfLunchDictionaries = [NSArray arrayWithObjects:goodLunchDictionary, noPerson1Dictionary,
                                                                  noPerson2Dictionary, noDateTimeDictionary, nil];

    NSData *data = [NSJSONSerialization dataWithJSONObject:arrayOfLunchDictionaries options:NSJSONWritingPrettyPrinted error:nil];
    NSArray *allLunches = [[LunchParser singleton] parseLunches:data];
    XCTAssertEqual(1, [allLunches count]);
    [self checkLunchAtIndex:person1 expectedPerson2:person2 dateString:dateString1 location:expectedLocation allLunches:allLunches index:0];


}

- (void)testParseLunches_WillAcceptLunchesWithNullLocation {


    Person *person1 = [[Person alloc] initWithId:@"adsa" firstName:@"Jimmy" lastName:@"Jazz" email:@"jimjazz@gmail.com"];
    Person *person2 = [[Person alloc] initWithId:@"t635" firstName:@"Janie" lastName:@"Jones" email:@"janiej@yahoo.com"];

    NSDictionary *person1Dictionary = [self buildPersonDictionary:person1];
    NSDictionary *person2Dictionary = [self buildPersonDictionary:person2];

    Location *expectedLocation = [[Location alloc] initWithName:@"Ashley's" address:@"338 S State St" andZipCode:@"48104"];

    NSDictionary *locationDictionary = [self buildLocationDictionary:expectedLocation];

    NSString *dateString1 = @"2017-11-07T12:30:00.000Z";
    NSDictionary *goodLunchDictionary = [NSDictionary dictionaryWithObjectsAndKeys:person1Dictionary, @"person1", person2Dictionary, @"person2", dateString1, @"dateTime", locationDictionary, @"location", nil];
    NSDictionary *noLocationDictionary = [NSDictionary dictionaryWithObjectsAndKeys:person1Dictionary, @"person1", person2Dictionary, @"person2", dateString1, @"dateTime", nil];
    NSArray *arrayOfLunchDictionaries = [NSArray arrayWithObjects:goodLunchDictionary, noLocationDictionary, nil];

    NSData *data = [NSJSONSerialization dataWithJSONObject:arrayOfLunchDictionaries options:NSJSONWritingPrettyPrinted error:nil];
    NSArray *allLunches = [[LunchParser singleton] parseLunches:data];
    XCTAssertEqual(2, [allLunches count]);
    [self checkLunchAtIndex:person1 expectedPerson2:person2 dateString:dateString1 location:expectedLocation allLunches:allLunches index:0];
    [self checkLunchAtIndex:person1 expectedPerson2:person2 dateString:dateString1 location:[NullLocation singleton] allLunches:allLunches index:1];
}


- (void)testBuildLunchJSON {
    Person *person1 = [[Person alloc] initWithId:@"2t23f" firstName:@"Kevin" lastName:@"Murphy" email:@"tservo@sol.net"];
    Person *person2 = [[Person alloc] initWithId:@"dfsgg" firstName:@"Bill" lastName:@"Corbett" email:@"crow@sol.net"];
    NSDate *theNotToDistantFuture = [NSDate distantFuture];
    Lunch *lunch = [[Lunch alloc] initWithPerson1:person1 person2:person2 dateTime:theNotToDistantFuture andLocation:nil];


    NSDictionary *person1Dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[person1 getFirstName], @"firstName", [person1 getLastName], @"lastName", [person1 getEmailAddress], @"email", [person1 getId], @"_id", nil];
    NSDictionary *person2Dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[person2 getFirstName], @"firstName", [person2 getLastName], @"lastName", [person2 getEmailAddress], @"email", [person2 getId], @"_id", nil];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-dd-MM'T'HH:mm:ss.SSSZ"];
    NSString *jsonDate = [formatter stringFromDate:theNotToDistantFuture];


    NSDictionary *lunchDictionary = [NSDictionary dictionaryWithObjectsAndKeys:person1Dictionary, @"person1", person2Dictionary, @"person2", jsonDate, @"dateTime", nil];
    NSDictionary *expectedDictionary = [NSDictionary dictionaryWithObjectsAndKeys:lunchDictionary, @"lunch", nil];
    NSData *expectedData = [NSJSONSerialization dataWithJSONObject:expectedDictionary options:NSJSONWritingPrettyPrinted error:nil];

    NSData *data = [[LunchParser singleton] buildLunchJSONData:lunch];
    XCTAssertEqualObjects(expectedData, data);

}

- (NSDictionary *)buildLocationDictionary:(Location *)location {
    return [NSDictionary dictionaryWithObjectsAndKeys:[location getName], @"name", [location getAddress], @"address", [location getZipCode], @"zipCode", nil];

}

- (NSDictionary *)buildPersonDictionary:(Person *)person {
    return [NSDictionary dictionaryWithObjectsAndKeys:[person getId], @"_id", [person getFirstName], @"firstName", [person getLastName], @"lastName", [person getEmailAddress], @"email", nil];
}

- (void)checkLunchAtIndex:(Person *)expectedPerson1
          expectedPerson2:(Person *)expectedPerson2
               dateString:(NSString *)dateString
                 location:(NSObject <LocationProtocol> *)expectedLocation
               allLunches:(NSArray *)allLunches index:(int)index {
    XCTAssertTrue([allLunches[index] isKindOfClass:[Lunch class]]);
    Lunch *lunch = (Lunch *) allLunches[index];

    NSDateFormatter *dateMaker = [[NSDateFormatter alloc] init];
    [dateMaker setDateFormat:@"yyyy-dd-MM'T'HH:mm:ss.SSSZ"];
    XCTAssertEqualObjects(expectedPerson1, [lunch getPerson1]);
    XCTAssertEqualObjects(expectedPerson2, [lunch getPerson2]);
    XCTAssertEqualObjects(expectedLocation, [lunch getLocation]);
    XCTAssertEqualObjects([dateMaker dateFromString:dateString], [lunch getDateAndTime]);
}


@end