//
//  MainViewControllerTest.m
//  lunchLunch
//
//  Created by Cyrus on 4/2/14.
//  Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MainViewController.h"
#import "Person.h"
#import "SwizzleHelper.h"
#import "SegueCommand.h"
#import "LunchProviderTestHelper.h"
#import "Lunch.h"
#import "MockUITableView.h"
#import "CommandDispatcherTestHelper.h"
#import "DetailViewController.h"

NSObject <PersonProtocol> *personToReturn;

@interface MainViewControllerTest : XCTestCase

@property(nonatomic, strong) MainViewController *viewController;
@end

@implementation MainViewControllerTest

- (void)setUp {
    [super setUp];
    self.viewController = [[MainViewController alloc] init];
    [LunchProviderTestHelper swizzleGetLunchesForPerson];
    [CommandDispatcherTestHelper swizzleExecute];


}

- (void)tearDown {
    [LunchProviderTestHelper deswizzleGetLunchesForPersonAndClearFields];
    [CommandDispatcherTestHelper deswizzleExecuteAndClearLastCommandExecuted];
    self.viewController = nil;
    [super tearDown];
}

- (void)testWillUseLoggedInPersonToFindLunchesWhenViewDidLoad {
    Person *loggedInPerson = [[Person alloc] init];
    self.viewController.personLoggedIn = loggedInPerson;
    [self.viewController viewDidLoad];
    XCTAssertEqual(loggedInPerson, [LunchProviderTestHelper getPersonUsedToFindLunches]);

}


- (void)testUsesFoundListOfLunchesToProvideNumberOfRows {
    [LunchProviderTestHelper setLunchesToReturn:@[[[Lunch alloc] init], [[Lunch alloc] init], [[Lunch alloc] init], [[Lunch alloc] init], [[Lunch alloc] init]]];
    [self.viewController viewDidLoad];
    XCTAssertEqual(5, [self.viewController tableView:nil numberOfRowsInSection:0]);
}

- (void)testCellForRowAtIndexPathWillSetLunchFromThatCell {

    Person *loggedInPerson = [[Person alloc] init];

    NSDateFormatter *dateMaker = [[NSDateFormatter alloc] init];
    [dateMaker setDateFormat:@"MM/dd/yyyy HH:mm"];
    NSDate *date = [dateMaker dateFromString:@"5/12/2103 14:30"];

    Person *personTheLunchIsWith = [[Person alloc] initWithFirstName:@"Bob" lastName:@"Soomy" email:@""];
    self.viewController.personLoggedIn = loggedInPerson;

    Lunch *lunch = [[Lunch alloc] init];

    Lunch *lunchToUse = [[Lunch alloc] initWithPerson1:loggedInPerson person2:personTheLunchIsWith dateTime:date];
    [LunchProviderTestHelper setLunchesToReturn:@[lunch, lunch, lunch, lunchToUse, lunch]];
    [self.viewController viewDidLoad];

    MockUITableView *tableView = [[MockUITableView alloc] init];
    UITableViewCell *cellToReturn = [[UITableViewCell alloc] init];
    [tableView setCellToReturn:cellToReturn];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:3 inSection:1];

    NSString *expectedText = @"5/12/2103 at 2:30 PM";


    [self checkViewCellBuilt:tableView cellToReturn:cellToReturn indexPath:indexPath expectedText:expectedText];
}

- (void)testCellForRowAtIndexPathWillSetLunchFromThatCell_WhenLoggedInPersonIsPerson2OnTheLunch {

    Person *loggedInPerson = [[Person alloc] init];

    NSDateFormatter *dateMaker = [[NSDateFormatter alloc] init];
    [dateMaker setDateFormat:@"MM/dd/yyyy HH:mm"];
    NSDate *date = [dateMaker dateFromString:@"12/2/2103 11:30"];

    Person *personTheLunchIsWith = [[Person alloc] initWithFirstName:@"Abdi" lastName:@"LaRue" email:@""];
    self.viewController.personLoggedIn = loggedInPerson;

    Lunch *lunch = [[Lunch alloc] init];

    Lunch *lunchToUse = [[Lunch alloc] initWithPerson1:personTheLunchIsWith person2:loggedInPerson dateTime:date];
    [LunchProviderTestHelper setLunchesToReturn:@[lunch, lunch, lunch, lunch, lunchToUse]];
    [self.viewController viewDidLoad];

    MockUITableView *tableView = [[MockUITableView alloc] init];
    UITableViewCell *cellToReturn = [[UITableViewCell alloc] init];
    [tableView setCellToReturn:cellToReturn];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:4 inSection:1];
    NSString *expectedText = @"12/2/2103 at 11:30 AM";

    [self checkViewCellBuilt:tableView cellToReturn:cellToReturn indexPath:indexPath expectedText:expectedText];
}

- (void)checkViewCellBuilt:(MockUITableView *)tableView cellToReturn:(UITableViewCell *)cellToReturn indexPath:(NSIndexPath *)indexPath expectedText:(NSString *)expectedText {
    UITableViewCell *viewCell = [self.viewController tableView:tableView cellForRowAtIndexPath:indexPath];
    XCTAssertEqualObjects(cellToReturn, viewCell);
    XCTAssertEqualObjects(@"LunchCell", [tableView getIdentifierForDequeue]);
    XCTAssertEqualObjects(indexPath, [tableView getIndexPathForDequeue]);
    XCTAssertEqualObjects(expectedText, cellToReturn.textLabel.text);
}


- (void)testWillFireSegueCommandWhenARowISelectedOnTheTable {


    XCTAssertNil([CommandDispatcherTestHelper getLastCommandExecuted]);
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:3 inSection:1];
    [self.viewController tableView:self.viewController.lunchTable didSelectRowAtIndexPath:indexPath];
    XCTAssertTrue([[CommandDispatcherTestHelper getLastCommandExecuted] isKindOfClass:[SegueCommand class]]);
    SegueCommand *command = (SegueCommand *) [CommandDispatcherTestHelper getLastCommandExecuted];
    XCTAssertEqualObjects(@"seeDetails", [command getSegueIdentifier]);
    XCTAssertEqualObjects(self.viewController, [command getViewController]);


}

- (void)testWhenARowIsSelectedTheLunchBePassedAlongToViewControllerOnTheSegue {

    XCTAssertNil([CommandDispatcherTestHelper getLastCommandExecuted]);
    Person *personLoggedIn = [[Person alloc] init];
    self.viewController.personLoggedIn  = personLoggedIn;
    Lunch *lunchToPassAlong = [[Lunch alloc] init];
    [LunchProviderTestHelper setLunchesToReturn:@[[[Lunch alloc] init], [[Lunch alloc] init], [[Lunch alloc] init], lunchToPassAlong, [[Lunch alloc] init]]];
    [self.viewController viewDidLoad];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:3 inSection:1];
    [self.viewController tableView:self.viewController.lunchTable didSelectRowAtIndexPath:indexPath];

    DetailViewController *destinationViewController = [[DetailViewController alloc] init];
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"seeDetails" source:self.viewController destination:destinationViewController];

    XCTAssertNil(destinationViewController.personLoggedIn);
    XCTAssertNil(destinationViewController.lunch);
    [self.viewController prepareForSegue:segue sender:self.viewController];

    XCTAssertEqual(lunchToPassAlong, destinationViewController.lunch);
    XCTAssertEqual(personLoggedIn, destinationViewController.personLoggedIn);

}

@end
