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
#import "LocationSelectionController.h"


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


    Lunch *lunch = [[[Lunch alloc] initWithId:nil person1:loggedInPerson person2:[[Person alloc] init] dateTime:[NSDate alloc] andLocation:nil] init];
    self.viewController.lunch = lunch;
    DetailsTableViewController *destinationViewController = [[DetailsTableViewController alloc] init];
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"detailsTable" source:self.viewController destination:destinationViewController];

    XCTAssertNil(destinationViewController.personLoggedIn);
    XCTAssertNil(destinationViewController.lunch);
    [self.viewController prepareForSegue:segue sender:self.viewController];

    XCTAssertEqual(lunch, destinationViewController.lunch);
    XCTAssertEqual(loggedInPerson, destinationViewController.personLoggedIn);
}


- (void)testWillPassLunchToLocationSelectionControllerOnSegue {
    Person *loggedInPerson = [[Person alloc] init];

    self.viewController.personLoggedIn = loggedInPerson;


    Lunch *lunch = [[[Lunch alloc] initWithId:nil person1:loggedInPerson person2:[[Person alloc] init] dateTime:[NSDate alloc] andLocation:nil] init];
    self.viewController.lunch = lunch;
    LocationSelectionController *destinationViewController = [[LocationSelectionController alloc] init];
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"specifyLocation" source:self.viewController destination:destinationViewController];

    XCTAssertNil(destinationViewController.lunch);
    [self.viewController prepareForSegue:segue sender:self.viewController];

    XCTAssertEqual(lunch, destinationViewController.lunch);
}
- (void)testViewDidWillSetFindLunchLocationButtonTextToFindLunchLocationIfALocationIsSpecified {

    MockDisplayHandler *mockDisplayHandler = [[MockDisplayHandler alloc] init];
    [DisplayHandlerFactoryTestHelper setDisplayHandlerToBuild:mockDisplayHandler];
    Lunch *lunch = [[Lunch alloc] initWithId:nil person1:[[Person alloc] init] person2:[[Person alloc] init] dateTime:[NSDate alloc] andLocation:[[Location alloc] init] ];
    self.viewController.lunch = lunch;
    UIButton *locationButton = [[UIButton alloc] init];
    self.viewController.lunchLocationButton = locationButton;

    [self.viewController viewDidLoad];
    XCTAssertEqualObjects(@"Find Lunch Location", [locationButton titleForState: UIControlStateNormal]);
}

- (void)testViewDidWillSetFindLunchLocationButtonTextToSpecifyLunchLocationIfNoLocationIsSpecified {

    MockDisplayHandler *mockDisplayHandler = [[MockDisplayHandler alloc] init];
    [DisplayHandlerFactoryTestHelper setDisplayHandlerToBuild:mockDisplayHandler];
    Lunch *lunch = [[Lunch alloc] initWithId:nil person1:[[Person alloc] init] person2:[[Person alloc] init] dateTime:[NSDate alloc] andLocation:[NullLocation singleton]];
    self.viewController.lunch = lunch;
    UIButton *locationButton = [[UIButton alloc] init];
    self.viewController.lunchLocationButton = locationButton;

    [self.viewController viewDidLoad];
    XCTAssertEqualObjects(@"Set Lunch Location", [locationButton titleForState: UIControlStateNormal]);
}


- (void)testFindLunchLocationButton {
    [self.viewController viewDidLoad];
    Lunch *lunch = [[[Lunch alloc] initWithId:nil person1:[[Person alloc] init] person2:[[Person alloc] init] dateTime:[NSDate alloc] andLocation:[[Location alloc] init]] init];
    self.viewController.lunch = lunch;
    [self.viewController findLunchLocationPushed:nil];

    XCTAssertTrue([[CommandDispatcherTestHelper getLastCommandExecuted] isKindOfClass:[ShowMapCommand class]]);
    ShowMapCommand *command = (ShowMapCommand *) [CommandDispatcherTestHelper getLastCommandExecuted];
    XCTAssertEqualObjects(self.viewController, [command getLocationManagerDelegate]);
    XCTAssertTrue([[command getLocationManager] isKindOfClass:[CLLocationManager class]]);
}

- (void)testSetLunchLocationButton_WhenLocationIsNull {
    [self.viewController viewDidLoad];
    Lunch *lunch = [[[Lunch alloc] initWithId:nil person1:[[Person alloc] init] person2:[[Person alloc] init] dateTime:[NSDate alloc] andLocation:[NullLocation singleton] ] init];
    self.viewController.lunch = lunch;
    [self.viewController findLunchLocationPushed:nil];

    XCTAssertTrue([[CommandDispatcherTestHelper getLastCommandExecuted] isKindOfClass:[SegueCommand class]]);
    SegueCommand *command = (SegueCommand *) [CommandDispatcherTestHelper getLastCommandExecuted];
    XCTAssertEqualObjects(@"specifyLocation", [command getSegueIdentifier]);
    XCTAssertEqualObjects(self.viewController, [command getViewController]);
}




- (void)testLocationDidUpdateToLocationWillShowMap {
    Location *lunchLocation = [[Location alloc] init];

    Lunch *lunch = [[[Lunch alloc] initWithId:nil person1:[[Person alloc] init] person2:[[Person alloc] init] dateTime:[NSDate alloc] andLocation:lunchLocation] init];
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
    Lunch *lunch = [[Lunch alloc] initWithId:nil person1:[[Person alloc] init] person2:[[Person alloc] init] dateTime:[NSDate alloc] andLocation:[NullLocation singleton]];
    self.viewController.lunch = lunch;
    MockCLLocationManager *locationManager = [[MockCLLocationManager alloc] init];
    [self.viewController locationManager:locationManager didFailWithError:nil];

    XCTAssertEqualObjects(@"There was an error determining your location, make sure location services are turned on", [mockDisplayHandler getErrorMessageShown]);
    XCTAssertTrue([locationManager wasStopUpdatingLocationCalled]);
}
@end