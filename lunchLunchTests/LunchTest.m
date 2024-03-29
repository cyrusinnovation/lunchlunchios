//
// Created by Cyrus on 4/4/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Lunch.h"

#import "Person.h"
#import "Location.h"

@interface LunchTest : XCTestCase
@end


@implementation LunchTest {

}

- (void)testIsOfCorrectProtocol {
    XCTAssertTrue([Lunch conformsToProtocol:@ protocol(LunchProtocol)]);
}

- (void)testInitAndGetFields {
    Person *expectedPerson1 = [[Person alloc] init];
    Person *expectedPerson2 = [[Person alloc] init];
    Location *expectedLocation = [[Location alloc] init];
    NSDate *expectedDateTime = [NSDate date];

    NSString *expectedId = @"5124";
    Lunch *lunch = [[Lunch alloc] initWithId:expectedId person1:expectedPerson1 person2:expectedPerson2 dateTime:expectedDateTime andLocation:expectedLocation];
    XCTAssertEqual(expectedPerson1, [lunch getPerson1]);
    XCTAssertEqual(expectedPerson2, [lunch getPerson2]);
    XCTAssertNotNil([lunch getDateAndTime]);
    XCTAssertEqual(expectedDateTime, [lunch getDateAndTime]);
    XCTAssertEqual(expectedLocation, [lunch getLocation]);
    XCTAssertEqual(expectedId, [lunch getId]);
}
@end