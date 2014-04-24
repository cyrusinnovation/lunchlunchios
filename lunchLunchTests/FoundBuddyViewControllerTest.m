//
// Created by Cyrus on 4/21/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "FoundBuddyViewController.h"
#import "PersonReceiverProtocol.h"
#import "Person.h"
#import "BuddyDetailViewController.h"
#import "LunchCreatorFactoryTestHelper.h"
#import "MockLunchCreator.h"
#import "Lunch.h"
#import "MockNavigationController.h"

@interface FoundBuddyViewControllerTest : XCTestCase
@property(nonatomic, strong) FoundBuddyViewController *viewController;
@end

@implementation FoundBuddyViewControllerTest {


}

- (void)setUp {
    [super setUp];
    self.viewController = [[FoundBuddyViewController alloc] init];
    [LunchCreatorFactoryTestHelper swizzleBuildLunchCreator];

}

- (void)tearDown {
    [LunchCreatorFactoryTestHelper deswizzleBuildLunchCreator];
    self.viewController = nil;
    [super tearDown];
}
-(void) testIsLunchReceiver{
    XCTAssertTrue([FoundBuddyViewController conformsToProtocol:@protocol(LunchCreationHandler)]);
}
- (void)testWillPassPropertiesToDetailsTableViewControllerOnSegue {
    Person *buddyFound = [[Person alloc] init];
    self.viewController.buddy = buddyFound;
    BuddyDetailViewController *destinationViewController = [[BuddyDetailViewController alloc] init];
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"buddyDetails" source:self.viewController destination:destinationViewController];
    XCTAssertNil(destinationViewController.buddy);
    [self.viewController prepareForSegue:segue sender:self.viewController];
    XCTAssertEqual(buddyFound, destinationViewController.buddy);
}


-(void)testCreateLunch{
    BuddyDetailViewController *destinationViewController = [[BuddyDetailViewController alloc] init];
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"buddyDetails" source:self.viewController destination:destinationViewController];

    Person *buddyFound = [[Person alloc] init];
    Person *loggedInPerson = [[Person alloc] init];
    self.viewController.buddy = buddyFound;
    self.viewController.personLoggedIn = loggedInPerson;
    NSDate *expectedDate = [NSDate distantPast];
    destinationViewController.date = expectedDate;
    MockLunchCreator *lunchCreator = [[MockLunchCreator alloc] init];
    [LunchCreatorFactoryTestHelper setLunchCreatorToReturn:lunchCreator];

    [self.viewController prepareForSegue:segue sender:self.viewController];

    [self.viewController createLunch:self.viewController];

    XCTAssertEqual(self.viewController, [LunchCreatorFactoryTestHelper getLunchCreationHandlerUsedToBuildLunchCreator]);

    XCTAssertTrue( [[lunchCreator getLunchCreated] isKindOfClass:[Lunch class]]);
    Lunch* actualLunch = (Lunch*)[lunchCreator getLunchCreated];
    XCTAssertEqual(loggedInPerson, [actualLunch getPerson1]);
    XCTAssertEqual(buddyFound, [actualLunch getPerson2]);
    XCTAssertEqual(expectedDate, [actualLunch getDateAndTime]);


}

-(void) testHandleLunchCreated{
    MockNavigationController *navController = [[MockNavigationController alloc] init];
    [navController pushViewController:self.viewController animated:true];

    [self.viewController handleLunchCreated];

    XCTAssertTrue([navController wasPopViewControllerAnimatedCalled]);
    XCTAssertTrue([navController shouldAnimatePop]);

}


@end