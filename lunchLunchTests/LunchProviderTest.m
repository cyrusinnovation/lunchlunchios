//
// Created by Cyrus on 4/9/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "LunchProvider.h"
#import "MockLunchRetriever.h"
#import "Lunch.h"
#import "Person.h"

@interface LunchProviderTest : XCTestCase
@end

@implementation LunchProviderTest {

}
- (void)testFindLunchesWillReturnLunchesThatThePersonIsAPartOf {
    Person *personToFind = [[Person alloc] initWithFirstName:@"Person" lastName:@"to" email:@"find"];
    Person *personEqualToPersonToFind = [[Person alloc] initWithFirstName:@"Person" lastName:@"to" email:@"find"];

    Lunch *lunchToFind1 = [[Lunch alloc] initWithPerson1:personToFind person2:[[Person alloc] init] dateTime:[[NSDate alloc] init]];
    Lunch *lunchToFind2 = [[Lunch alloc] initWithPerson1:personEqualToPersonToFind person2:[[Person alloc] init] dateTime:[[NSDate alloc] init]];
    Lunch *lunchToFind3 = [[Lunch alloc] initWithPerson1:[[Person alloc] init] person2:personEqualToPersonToFind dateTime:[[NSDate alloc] init]];
    Lunch *lunchToFind4 = [[Lunch alloc] initWithPerson1:[[Person alloc] init] person2:personToFind dateTime:[[NSDate alloc] init]];
    Lunch *otherLunch1 = [[Lunch alloc] init];
    Lunch *otherLunch2 = [[Lunch alloc] init];
    Lunch *otherLunch3 = [[Lunch alloc] init];
    Lunch *otherLunch4 = [[Lunch alloc] init];

    NSArray *allLunches = [NSArray arrayWithObjects:otherLunch1, lunchToFind1, otherLunch2, otherLunch3, lunchToFind2, lunchToFind3, otherLunch4, lunchToFind4, nil];


    MockLunchRetriever *mockLunchRetriever = [[MockLunchRetriever alloc] init];
    [mockLunchRetriever setAllLunchesToReturn:allLunches];
    LunchProvider *lunchProvider = [[LunchProvider alloc] initWithLunchRetriever:mockLunchRetriever];

    NSArray *lunchesForPerson = [lunchProvider findLunchesFor:personToFind];
    XCTAssertEqual(4, [lunchesForPerson count]);
    XCTAssertEqualObjects(lunchToFind1, [lunchesForPerson objectAtIndex:0] );
    XCTAssertEqualObjects(lunchToFind2, [lunchesForPerson objectAtIndex:1] );
    XCTAssertEqualObjects(lunchToFind3, [lunchesForPerson objectAtIndex:2] );
    XCTAssertEqualObjects(lunchToFind4, [lunchesForPerson objectAtIndex:3] );
}

- (void)testFindLunchesWillOrderFoundLunchesByDate {
    Person *personToFind = [[Person alloc] initWithFirstName:@"Person" lastName:@"to" email:@"find"];

    NSDateFormatter *dateMaker = [[NSDateFormatter alloc] init];
    [dateMaker setDateFormat:@"MM/dd/yyyy"];

    NSDate *earliestDate = [dateMaker dateFromString:@"4/22/2014"];
    NSDate *latestDate = [dateMaker dateFromString:@"8/22/2014"];
    NSDate *midDate = [dateMaker dateFromString:@"4/30/2014"];



    Lunch *latestLunchToFind = [[Lunch alloc] initWithPerson1:personToFind person2:[[Person alloc] init] dateTime:latestDate];
    Lunch *earliestLunchToFind = [[Lunch alloc] initWithPerson1:personToFind person2:[[Person alloc] init] dateTime:earliestDate];
    Lunch *middleLunchToFind = [[Lunch alloc] initWithPerson1:[[Person alloc] init] person2:personToFind dateTime:midDate];

    NSArray *allLunches = [NSArray arrayWithObjects:latestLunchToFind, earliestLunchToFind, middleLunchToFind, nil];

    MockLunchRetriever *mockLunchRetriever = [[MockLunchRetriever alloc] init];
    [mockLunchRetriever setAllLunchesToReturn:allLunches];

    LunchProvider *lunchProvider = [[LunchProvider alloc] initWithLunchRetriever:mockLunchRetriever];

    NSArray *lunchesForPerson = [lunchProvider findLunchesFor:personToFind];
    XCTAssertEqual(3, [lunchesForPerson count]);

    XCTAssertNotNil([earliestLunchToFind getDateAndTime]);
    XCTAssertNotNil([middleLunchToFind getDateAndTime]);
    XCTAssertNotNil([latestLunchToFind getDateAndTime]);


    XCTAssertEqualObjects([earliestLunchToFind getDateAndTime], [[lunchesForPerson objectAtIndex:0] getDateAndTime] );
    XCTAssertEqualObjects([middleLunchToFind getDateAndTime], [[lunchesForPerson objectAtIndex:1] getDateAndTime] );
    XCTAssertEqualObjects([latestLunchToFind getDateAndTime], [[lunchesForPerson objectAtIndex:2] getDateAndTime] );


}

@end