//
// Created by Cyrus on 4/10/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//
#import <XCTest/XCTest.h>
#import "Person.h"
#import "DetailViewController.h"
#import "Lunch.h"
#import "DetailsTableViewController.h"
#import "SegueCommand.h"
#import "CommandDispatcherTestHelper.h"
#import "Location.h"
#import "MockDisplayHandler.h"
#import "DisplayHandlerFactoryTestHelper.h"
#import "NullLocation.h"
#import "LocationMapViewController.h"

@interface DetailViewControllerTest : XCTestCase
@property(nonatomic, strong) DetailViewController *viewController;
@end

@implementation DetailViewControllerTest {


}

- (void)setUp {
    [super setUp];
    self.viewController = [[DetailViewController alloc] init];
    [CommandDispatcherTestHelper swizzleExecute];
    [DisplayHandlerFactoryTestHelper swizzleBuildDisplayHandler];


}

- (void)tearDown {
    [CommandDispatcherTestHelper deswizzleExecuteAndClearLastCommandExecuted];
    [DisplayHandlerFactoryTestHelper deswizzleBuildDisplayHandler];
    self.viewController = nil;
    [super tearDown];
}

- (void)testWillPassPropertiesToDetailsTableViewControllerOnSegue {
    Person *loggedInPerson = [[Person alloc] init];

    self.viewController.personLoggedIn = loggedInPerson;


    Lunch *lunch = [[[Lunch alloc] initWithPerson1:loggedInPerson person2:[[Person alloc] init] dateTime:[NSDate alloc] andLocation:nil] init];
    self.viewController.lunch = lunch;
    DetailsTableViewController *destinationViewController = [[DetailsTableViewController alloc] init];
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"detailsTable" source:self.viewController destination:destinationViewController];

    XCTAssertNil(destinationViewController.personLoggedIn);
    XCTAssertNil(destinationViewController.lunch);
    [self.viewController prepareForSegue:segue sender:self.viewController];

    XCTAssertEqual(lunch, destinationViewController.lunch);
    XCTAssertEqual(loggedInPerson, destinationViewController.personLoggedIn);
}

- (void)testFindLunchLocationButton {
    Lunch *lunch = [[[Lunch alloc] initWithPerson1:[[Person alloc] init] person2:[[Person alloc] init] dateTime:[NSDate alloc] andLocation:[[Location alloc] init]] init];
    self.viewController.lunch = lunch;
    [self.viewController findLunchLocationPushed:nil];

    XCTAssertTrue([[CommandDispatcherTestHelper getLastCommandExecuted] isKindOfClass:[SegueCommand class]]);
    SegueCommand *command = (SegueCommand *) [CommandDispatcherTestHelper getLastCommandExecuted];
    XCTAssertEqualObjects(@"showMapView", [command getSegueIdentifier]);
    XCTAssertEqualObjects(self.viewController, [command getViewController]);
}

- (void)testSegueToMapViewWillPassAlongLocation {

    Location *location = [[Location alloc] init];
    Lunch *lunch = [[[Lunch alloc] initWithPerson1:[[Person alloc] init] person2:[[Person alloc] init] dateTime:[NSDate alloc] andLocation:location] init];
    self.viewController.lunch = lunch;
    LocationMapViewController *destinationViewController = [[LocationMapViewController alloc] init];
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"showMapView" source:self.viewController destination:destinationViewController];

    [self.viewController prepareForSegue:segue sender:self.viewController];

    XCTAssertEqual(location, destinationViewController.location);
}

- (void)testFindLunchLocationButtonWillShowMessageAndNotSegueIfThereIsNoLocationForThatLunch {
    MockDisplayHandler *mockDisplayHandler = [[MockDisplayHandler alloc] init];
    [DisplayHandlerFactoryTestHelper setDisplayHandlerToBuild:mockDisplayHandler];
    Lunch *lunch = [[Lunch alloc] initWithPerson1:[[Person alloc] init] person2:[[Person alloc] init] dateTime:[NSDate alloc] andLocation:[NullLocation singleton]];
    self.viewController.lunch = lunch;
    [self.viewController findLunchLocationPushed:nil];

    XCTAssertNil([CommandDispatcherTestHelper getLastCommandExecuted]);
    XCTAssertEqualObjects(@"This Lunch does not have a Location associate with it.", [mockDisplayHandler getErrorMessageShown]);

}
@end