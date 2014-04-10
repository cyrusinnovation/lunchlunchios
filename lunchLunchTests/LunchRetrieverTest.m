//
// Created by Cyrus on 4/4/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LunchRetriever.h"
#import "Person.h"
#import "Lunch.h"

@interface LunchRetrieverTest : XCTestCase
@end

@implementation LunchRetrieverTest {

}
- (void)testImplementsProtocol {
    XCTAssertTrue([LunchRetriever conformsToProtocol:@protocol(LunchRetrieverProtocol)]);
}

- (void)testGetAllLunchesReturnsStubSetOfLunches {

    Person *jjia = [[Person alloc] initWithFirstName:@"Jeff" lastName:@"Jia" email:@"jjia@cyrusinnovation.com"];
    Person *dblinn = [[Person alloc] initWithFirstName:@"David" lastName:@"Blinn" email:@"dblinn@cyrusinnovation.com"];
    Person *cmcenearney = [[Person alloc] initWithFirstName:@"Colin" lastName:@"McEnearney" email:@"cmcenearney@cyrusinnovation.com"];
    Person *blewis = [[Person alloc] initWithFirstName:@"Britt" lastName:@"Lewis" email:@"blewis@cyrusinnovation.com"];
    Person *lvangelder = [[Person alloc] initWithFirstName:@"Lisa" lastName:@"van Gelder" email:@"lvangelder@cyrusinnovation.com"];

    LunchRetriever *retriever = [[LunchRetriever alloc] init];
    NSArray *allLunches = [retriever getAllLunches];

    XCTAssertEqual(10, [allLunches count]);
    NSDateFormatter *dateMaker = [[NSDateFormatter alloc] init];
    [dateMaker setDateFormat:@"MM/dd/yyyy hh:mm"];
    [self checkLunch:allLunches atIndex:0 withPerson1:jjia withPerson2:dblinn andDateTime:[dateMaker dateFromString:@"12/22/2016 12:00"]];
    [self checkLunch:allLunches atIndex:1 withPerson1:jjia withPerson2:cmcenearney andDateTime:[dateMaker dateFromString:@"1/31/2016 12:30"]];
    [self checkLunch:allLunches atIndex:2 withPerson1:jjia withPerson2:blewis andDateTime:[dateMaker dateFromString:@"4/30/2016 1:00"]];
    [self checkLunch:allLunches atIndex:3 withPerson1:jjia withPerson2:lvangelder andDateTime:[dateMaker dateFromString:@"5/21/2016 1:30"]];
    [self checkLunch:allLunches atIndex:4 withPerson1:dblinn withPerson2:cmcenearney andDateTime:[dateMaker dateFromString:@"2/27/2016 12:00"]];
    [self checkLunch:allLunches atIndex:5 withPerson1:dblinn withPerson2:blewis andDateTime:[dateMaker dateFromString:@"11/13/2016 12:30" ]];
    [self checkLunch:allLunches atIndex:6 withPerson1:dblinn withPerson2:lvangelder andDateTime:[dateMaker dateFromString:@"9/12/2016 1:00"]];
    [self checkLunch:allLunches atIndex:7 withPerson1:cmcenearney withPerson2:blewis andDateTime:[dateMaker dateFromString:@"8/1/2016 1:30"]];
    [self checkLunch:allLunches atIndex:8 withPerson1:cmcenearney withPerson2:lvangelder andDateTime:[dateMaker dateFromString:@"6/12/2016 12:00"]];
    [self checkLunch:allLunches atIndex:9 withPerson1:blewis withPerson2:lvangelder andDateTime:[dateMaker dateFromString:@"4/22/2016 12:30"]];

}

- (void)checkLunch:(NSArray *)allLunches atIndex:(int)i withPerson1:(NSObject <PersonProtocol> *)person1 withPerson2:(NSObject <PersonProtocol> *)person2 andDateTime:(NSDate *)expectedDateTime {
    Lunch *lunch = [allLunches objectAtIndex:i];

    XCTAssertTrue([lunch isKindOfClass:[Lunch class]]);
    XCTAssertEqualObjects(person1, [lunch getPerson1]);
    XCTAssertEqualObjects(person2, [lunch getPerson2]);
    XCTAssertEqualObjects(expectedDateTime, [lunch getDateAndTime]);

}


@end

