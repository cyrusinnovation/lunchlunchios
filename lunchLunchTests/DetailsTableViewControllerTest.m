//
// Created by Cyrus on 4/10/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "DetailsTableViewController.h"
#import "Person.h"
#import "Lunch.h"

@interface DetailsTableViewControllerTest : XCTestCase

@end


@interface DetailsTableViewControllerTest ()
@property(nonatomic, strong) DetailsTableViewController *viewController;
@end

@implementation DetailsTableViewControllerTest {


}
- (void)setUp {
    [super setUp];
    self.viewController = [[DetailsTableViewController alloc] init];
    self.viewController.dateLabel = [[UILabel alloc] init];
    self.viewController.nameLabel = [[UILabel alloc] init];
    self.viewController.timeLabel = [[UILabel alloc] init];
}

- (void)tearDown {
    self.viewController=    nil;
    [super tearDown];
}

- (void)testWillShowLunchDetailsOnViewDidLoad {
    Person *loggedInPerson = [[Person alloc] init];

    NSDateFormatter *dateMaker = [[NSDateFormatter alloc] init];
    [dateMaker setDateFormat:@"MM/dd/yyyy HH:mm"];
    NSDate *date = [dateMaker dateFromString:@"5/12/2103 14:30"];

    self.viewController.personLoggedIn = loggedInPerson;
    Person *lunchBuddy = [[Person alloc] initWithFirstName:@"Stag" lastName:@"Bulkhead" email:@""];


    self.viewController.lunch = [[Lunch alloc] initWithPerson1:loggedInPerson person2:lunchBuddy dateTime:date];
    [self.viewController viewDidLoad];
    XCTAssertEqualObjects(@"Stag Bulkhead", [self.viewController.nameLabel text]);
    XCTAssertEqualObjects(@"5/12/2103", [self.viewController.dateLabel text]);
    XCTAssertEqualObjects(@"2:30 PM", [self.viewController.timeLabel text]);



}

- (void)testWillShowLunchDetailsOnViewDidLoad_LoggedInPersonIsPerson2 {
    Person *loggedInPerson = [[Person alloc] init];

    NSDateFormatter *dateMaker = [[NSDateFormatter alloc] init];
    [dateMaker setDateFormat:@"MM/dd/yyyy HH:mm"];
    NSDate *date = [dateMaker dateFromString:@"11/01/2103 11:30"];

    self.viewController.personLoggedIn = loggedInPerson;
    Person *lunchBuddy = [[Person alloc] initWithFirstName:@"Bulk" lastName:@"Vanderhuge" email:@""];


    self.viewController.lunch = [[Lunch alloc] initWithPerson1:lunchBuddy person2:loggedInPerson dateTime:date];
    [self.viewController viewDidLoad];
    XCTAssertEqualObjects(@"Bulk Vanderhuge", [self.viewController.nameLabel text]);
    XCTAssertEqualObjects(@"11/1/2103", [self.viewController.dateLabel text]);
    XCTAssertEqualObjects(@"11:30 AM", [self.viewController.timeLabel text]);

}
@end