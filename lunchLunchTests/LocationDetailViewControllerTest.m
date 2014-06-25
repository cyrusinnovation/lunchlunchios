//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//



#import <XCTest/XCTest.h>
#import "LocationDetailViewController.h"
#import "Location.h"
#import "LocationDetailTableViewController.h"
#import "LunchUpdateHandler.h"
#import "LunchUpdaterFactoryTestHelper.h"
#import "Lunch.h"
#import "MockLunchUpdater.h"
#import "MockNavigationController.h"
#import "DisplayHandlerFactoryTestHelper.h"
#import "MockDisplayHandler.h"

@interface LocationDetailViewControllerTest : XCTestCase
@property(nonatomic, strong) LocationDetailViewController *viewController;
@end

@implementation LocationDetailViewControllerTest {

}
- (void)setUp {
    [super setUp];
    self.viewController = [[LocationDetailViewController alloc] init];
    [LunchUpdaterFactoryTestHelper swizzleBuildLunchUpdater];
    [DisplayHandlerFactoryTestHelper swizzleBuildDisplayHandler];
}

- (void)tearDown {
    [LunchUpdaterFactoryTestHelper deswizzleBuildLunchUpdater];
    [DisplayHandlerFactoryTestHelper deswizzleBuildDisplayHandler];
    self.viewController = nil;
    [super tearDown];
}

- (void)testIsALunchUpdateHandler {
    XCTAssertTrue([LocationDetailViewController conformsToProtocol:@ protocol(LunchUpdateHandler)]);
}

- (void)testWillPassPropertiesToDetailsTableViewControllerOnSegue {

    Location *location = [[Location alloc] init];
    self.viewController.location = location;


    LocationDetailTableViewController *destinationViewController = [[LocationDetailTableViewController alloc] init];
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"locationDetailTable" source:self.viewController destination:destinationViewController];

    XCTAssertNil(destinationViewController.location);
    [self.viewController prepareForSegue:segue sender:self.viewController];

    XCTAssertEqual(location, destinationViewController.location);
}

- (void)testButtonPressedWillUpdateLunchWithLocationAndLunch {
    Location *location = [[Location alloc] init];
    Lunch *lunch = [[Lunch alloc] init];
    self.viewController.location = location;
    self.viewController.lunch = lunch;
    MockLunchUpdater *lunchUpdater = [[MockLunchUpdater alloc] init];
    [LunchUpdaterFactoryTestHelper setLunchUpdaterToReturn:lunchUpdater];

    [self.viewController updateLunchButtonPressed:nil];

    XCTAssertEqual(self.viewController, [LunchUpdaterFactoryTestHelper getLunchUpdateHandlerUsedToBuild]);
    XCTAssertEqual(location, [lunchUpdater getLocationForUpdate]);
    XCTAssertEqual(lunch, [lunchUpdater getLunchForUpdate]);
}

- (void)testHandleLunchUpdatedWillPopUpThreeLevels {
    MockNavigationController *navController = [[MockNavigationController alloc] init];
    [navController pushViewController:self.viewController animated:true];
    [self.viewController handleLunchUpdate];
    XCTAssertTrue([navController wasPopToRootCalled]);

}

- (void)testHandleLunchUpdateFailedWillShowConnectionError {
    MockDisplayHandler *handler = [[MockDisplayHandler alloc] init];
    [DisplayHandlerFactoryTestHelper setDisplayHandlerToBuild:handler];
    [self.viewController handleLunchUpdateFailed];

    XCTAssertTrue([handler wasShowCommunicationErrorCalled]);
}
@end