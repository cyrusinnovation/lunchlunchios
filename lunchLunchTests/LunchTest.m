//
// Created by Cyrus on 4/4/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//
    
#import <XCTest/XCTest.h>
#import "Lunch.h"

#import "Person.h"

@interface LunchTest : XCTestCase
@end


@implementation LunchTest {

}

- (void)testIsOfCorrectProtocol {
    XCTAssertTrue([Lunch conformsToProtocol:@protocol(LunchProtocol)]);
}

- (void) testInitAndGetFields{
    Person *expectedPerson1 = [[Person alloc] init];
    Person *expectedPerson2 = [[Person alloc] init];
    NSDate *expectedDateTime = [NSDate date];
    Lunch *lunch = [[Lunch alloc] initWithPerson1:expectedPerson1 person2:expectedPerson2 dateTime:expectedDateTime];
    XCTAssertEqual(expectedPerson1, [lunch getPerson1]);
    XCTAssertEqual(expectedPerson2, [lunch getPerson2]);
    XCTAssertNotNil([lunch getDateAndTime]);
    XCTAssertEqual(expectedDateTime, [lunch getDateAndTime]);
}
@end