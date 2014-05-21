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

#import "Lunch.h"
#import "MockUITableView.h"
#import "CommandDispatcherTestHelper.h"
#import "DetailViewController.h"
#import "LunchProviderFactoryTestHelper.h"
#import "MockLunchProvider.h"
#import "FoundBuddyViewController.h"
#import "BuddyFinderFactoryTestHelper.h"
#import "MockBuddyFinder.h"

#import "MockUIAlertView.h"
#import "DisplayHandlerFactoryTestHelper.h"
#import "MockDisplayHandler.h"

NSObject <PersonProtocol> *personToReturn;

@interface MainViewControllerTest : XCTestCase

@property(nonatomic, strong) MainViewController *viewController;
@end

@implementation MainViewControllerTest {
    MockDisplayHandler *mockDisplayHandler;
}

- (void)setUp {
    [super setUp];
    self.viewController = [[MainViewController alloc] init];
    [LunchProviderFactoryTestHelper swizzleBuildLunchProvider];
    [BuddyFinderFactoryTestHelper swizzleBuildBuddyFinder];
    [CommandDispatcherTestHelper swizzleExecute];

    mockDisplayHandler = [[MockDisplayHandler alloc] init];
    [DisplayHandlerFactoryTestHelper setDisplayHandlerToBuild:mockDisplayHandler];
}

- (void)tearDown {
    [LunchProviderFactoryTestHelper deswizzleBuildLunchProvider];
    [BuddyFinderFactoryTestHelper deswizzleBuildBuddyFinder];
    [CommandDispatcherTestHelper deswizzleExecuteAndClearLastCommandExecuted];
    [DisplayHandlerFactoryTestHelper deswizzleBuildDisplayHandler];
    self.viewController = nil;
    [super tearDown];
}

- (void)testWillUseLoggedInPersonToFindLunchesWhenViewWillAppear {
    Person *loggedInPerson = [[Person alloc] init];
    self.viewController.personLoggedIn = loggedInPerson;
    MockLunchProvider *mockLunchProvider = [[MockLunchProvider alloc] init];

    [LunchProviderFactoryTestHelper setLunchProviderToReturn:mockLunchProvider];
    
    [self.viewController viewWillAppear:true];
    XCTAssertEqual(self.viewController, [LunchProviderFactoryTestHelper getLunchReceiverUsedToBuildLunchProvider]);
    XCTAssertEqual(loggedInPerson, [mockLunchProvider getPersonToFindLunchesFor]);
}
- (void)testIsALunchReceiver {
    XCTAssertTrue([MainViewController conformsToProtocol:@protocol(LunchReceiverProtocol)]);
}
- (void)testIsAPersonReceiver {
    XCTAssertTrue([MainViewController conformsToProtocol:@protocol(PersonReceiverProtocol)]);
}

- (void)testUsesFoundListOfLunchesToProvideNumberOfRows {
    [self.viewController handleLunchesFound:@[[[Lunch alloc] init], [[Lunch alloc] init], [[Lunch alloc] init], [[Lunch alloc] init], [[Lunch alloc] init]]];
  
    XCTAssertEqual(5, [self.viewController tableView:nil numberOfRowsInSection:0]);
}
- (void)testHandleLunchesFoundWillTellTableToReload {
    MockUITableView *mockTable = [[MockUITableView alloc] init];
    self.viewController.lunchTable = mockTable;
    
    [self.viewController handleLunchesFound:@[[[Lunch alloc] init]]];

    XCTAssertTrue([mockTable wasReloadDataCalled]);
}

- (void)testCellForRowAtIndexPathWillSetLunchFromThatCell {

    Person *loggedInPerson = [[Person alloc] init];

    NSDateFormatter *dateMaker = [[NSDateFormatter alloc] init];
    [dateMaker setDateFormat:@"MM/dd/yyyy HH:mm"];
    NSDate *date = [dateMaker dateFromString:@"5/12/2103 14:30"];

    Person *personTheLunchIsWith = [[Person alloc] initWithId:nil firstName:@"Bob" lastName:@"Soomy" email:@""];
    self.viewController.personLoggedIn = loggedInPerson;

    Lunch *lunch = [[Lunch alloc] init];

    Lunch *lunchToUse = [[Lunch alloc] initWithPerson1:loggedInPerson person2:personTheLunchIsWith dateTime:date andLocation:nil ];
    [self.viewController handleLunchesFound:@[lunch, lunch, lunch, lunchToUse, lunch]];
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

    Person *personTheLunchIsWith = [[Person alloc] initWithId:nil firstName:@"Abdi" lastName:@"LaRue" email:@""];
    self.viewController.personLoggedIn = loggedInPerson;

    Lunch *lunch = [[Lunch alloc] init];

    Lunch *lunchToUse = [[Lunch alloc] initWithPerson1:personTheLunchIsWith person2:loggedInPerson dateTime:date andLocation:nil ];
    [self.viewController handleLunchesFound:@[lunch, lunch, lunch, lunch, lunchToUse]];
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

-(void) testWillFindBuddyForLoggedInPersonWhenButtonIsClicked{
    Person *loggedInPerson = [[Person alloc] init];
    self.viewController.personLoggedIn = loggedInPerson;
    MockBuddyFinder *buddyFinder = [[MockBuddyFinder alloc] init];

    [BuddyFinderFactoryTestHelper setBuddyFinderToReturn:buddyFinder];

    [self.viewController findBuddyClicked:nil];
    XCTAssertEqual(self.viewController, [BuddyFinderFactoryTestHelper getPersonReceiverUsedToBuildBuddyFinder]);
    XCTAssertEqual(loggedInPerson, [buddyFinder getPersonUsedToFindBuddy]);


}

- (void)testWillFireSegueCommandWhenABuddyIsFound {

    XCTAssertNil([CommandDispatcherTestHelper getLastCommandExecuted]);
    [self.viewController handlePersonFound:[[Person alloc] init] ];

    XCTAssertTrue([[CommandDispatcherTestHelper getLastCommandExecuted] isKindOfClass:[SegueCommand class]]);
    SegueCommand *command = (SegueCommand *) [CommandDispatcherTestHelper getLastCommandExecuted];
    XCTAssertEqualObjects(@"findBuddy", [command getSegueIdentifier]);
    XCTAssertEqualObjects(self.viewController, [command getViewController]);

}

- (void)testPersonFoundAndPersonLoggedInArePassedAlongWithTheFindBuddySegue {

    XCTAssertNil([CommandDispatcherTestHelper getLastCommandExecuted]);
    Person *personLoggedIn = [[Person alloc] init];
    self.viewController.personLoggedIn = personLoggedIn;

    Person *personFound = [[Person alloc] init];
    [self.viewController handlePersonFound:personFound];
    FoundBuddyViewController *destinationViewController = [[FoundBuddyViewController alloc] init];
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"findBuddy" source:self.viewController destination:destinationViewController];

    XCTAssertNil(destinationViewController.buddy);
    [self.viewController prepareForSegue:segue sender:self.viewController];

    XCTAssertEqual(personFound, destinationViewController.buddy);
    XCTAssertEqual(personLoggedIn, destinationViewController.personLoggedIn);
}

- (void)testWhenARowIsSelectedTheLunchBePassedAlongToViewControllerOnTheSeeDetailsSegue {

    XCTAssertNil([CommandDispatcherTestHelper getLastCommandExecuted]);
    Person *personLoggedIn = [[Person alloc] init];
    self.viewController.personLoggedIn  = personLoggedIn;
    Lunch *lunchToPassAlong = [[Lunch alloc] init];
    [self.viewController handleLunchesFound:@[[[Lunch alloc] init], [[Lunch alloc] init], [[Lunch alloc] init], lunchToPassAlong, [[Lunch alloc] init]]];
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


- (void)testHandlePersonFoundError {
    [self.viewController handlePersonFoundError];
    XCTAssertTrue([mockDisplayHandler wasShowCommunicationErrorCalled]);
}
@end
