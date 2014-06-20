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
#import "MockCLLocationManagerDelegate.h"
#import "ShowMapCommand.h"
#import "DirectionsProviderFactory.h"
#import "DirectionProviderFactoryTestHelper.h"
#import "MockDirectionsProvider.h"
#import "MockCLLocationManager.h"


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
    [DirectionProviderFactoryTestHelper swizzleBuildDirectionProvider];


}

- (void)tearDown {
    [CommandDispatcherTestHelper deswizzleExecuteAndClearLastCommandExecuted];
    [DisplayHandlerFactoryTestHelper deswizzleBuildDisplayHandler];
    [DirectionProviderFactoryTestHelper deswizzleBuildDirectionProvider];
    self.viewController = nil;
    [super tearDown];
}

- (void)testIsALocationManagerDelegate {
    XCTAssertTrue([DetailViewController conformsToProtocol:@ protocol(CLLocationManagerDelegate)]);
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
    [self.viewController viewDidLoad];
    Lunch *lunch = [[[Lunch alloc] initWithPerson1:[[Person alloc] init] person2:[[Person alloc] init] dateTime:[NSDate alloc] andLocation:[[Location alloc] init]] init];
    self.viewController.lunch = lunch;
    [self.viewController findLunchLocationPushed:nil];

    XCTAssertTrue([[CommandDispatcherTestHelper getLastCommandExecuted] isKindOfClass:[ShowMapCommand class]]);
    ShowMapCommand *command = (ShowMapCommand *) [CommandDispatcherTestHelper getLastCommandExecuted];
    XCTAssertEqualObjects(self.viewController, [command getLocationManagerDelegate]);
    XCTAssertTrue([[command getLocationManager] isKindOfClass:[CLLocationManager class]]);
}


- (void)testFindLunchLocationButtonWillShowMessageAndNotFireCommandIfThereIsNoLocationForThatLunch {

    MockDisplayHandler *mockDisplayHandler = [[MockDisplayHandler alloc] init];
    [DisplayHandlerFactoryTestHelper setDisplayHandlerToBuild:mockDisplayHandler];
    Lunch *lunch = [[Lunch alloc] initWithPerson1:[[Person alloc] init] person2:[[Person alloc] init] dateTime:[NSDate alloc] andLocation:[NullLocation singleton]];
    self.viewController.lunch = lunch;
    [self.viewController findLunchLocationPushed:nil];

    XCTAssertNil([CommandDispatcherTestHelper getLastCommandExecuted]);
    XCTAssertEqualObjects(@"This Lunch does not have a Location associate with it.", [mockDisplayHandler getErrorMessageShown]);
}


- (void)testLocationDidUpdateToLocationWillShowMap {
    Location *lunchLocation = [[Location alloc] init];

    Lunch *lunch = [[[Lunch alloc] initWithPerson1:[[Person alloc] init] person2:[[Person alloc] init] dateTime:[NSDate alloc] andLocation:lunchLocation] init];
    self.viewController.lunch = lunch;
    MockDirectionsProvider *directionsProvider = [[MockDirectionsProvider alloc] init];
    [DirectionProviderFactoryTestHelper setDirectionProviderToReturn:directionsProvider];

    CLLocation *expectedOrigin = [[CLLocation alloc] initWithLatitude:231 longitude:3523];
    MockCLLocationManager *locationManager = [[MockCLLocationManager alloc] init];
    [self.viewController locationManager:locationManager didUpdateLocations:[NSArray arrayWithObjects:expectedOrigin, nil]];
    XCTAssertEqualObjects(lunchLocation, [directionsProvider getLocationForFindDirection]);
    XCTAssertEqualObjects(expectedOrigin, [directionsProvider getOriginForFindDirection]);
    XCTAssertTrue([locationManager wasStopUpdatingLocationCalled]);

}

- (void)testDidFailWithErrorWillShowErrorMessage{

    MockDisplayHandler *mockDisplayHandler = [[MockDisplayHandler alloc] init];
    [DisplayHandlerFactoryTestHelper setDisplayHandlerToBuild:mockDisplayHandler];
    Lunch *lunch = [[Lunch alloc] initWithPerson1:[[Person alloc] init] person2:[[Person alloc] init] dateTime:[NSDate alloc] andLocation:[NullLocation singleton]];
    self.viewController.lunch = lunch;
    MockCLLocationManager *locationManager = [[MockCLLocationManager alloc] init];
    [self.viewController locationManager:locationManager didFailWithError:nil];

    XCTAssertEqualObjects(@"There was an error determining your location, make sure location services are turned on", [mockDisplayHandler getErrorMessageShown]);
    XCTAssertTrue([locationManager wasStopUpdatingLocationCalled]);
}
@end