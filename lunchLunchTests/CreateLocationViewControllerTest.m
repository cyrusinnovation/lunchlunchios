//
// Created by Cyrus on 6/25/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CreateLocationViewController.h"
#import "LocationWriterFactoryTestHelper.h"
#import "CreateLocationSubController.h"
#import "MockLocationWriter.h"
#import "Location.h"
#import "LunchUpdaterFactoryTestHelper.h"
#import "MockLunchUpdater.h"
#import "Lunch.h"
#import "MockNavigationController.h"
#import "DisplayHandlerFactoryTestHelper.h"
#import "MockDisplayHandler.h"

@interface CreateLocationViewControllerTest : XCTestCase
@property(nonatomic, strong) CreateLocationViewController *viewController;
@end

@implementation CreateLocationViewControllerTest {

}

- (void)setUp {
    [super setUp];
    self.viewController = [[CreateLocationViewController alloc] init];
    [LocationWriterFactoryTestHelper swizzleBuildLocationWriter];
    [LunchUpdaterFactoryTestHelper swizzleBuildLunchUpdater];
    [DisplayHandlerFactoryTestHelper swizzleBuildDisplayHandler];

}

- (void)tearDown {
    self.viewController = nil;
    [LocationWriterFactoryTestHelper deswizzleBuildLocationWriter];
    [LunchUpdaterFactoryTestHelper deswizzleBuildLunchUpdater];
    [DisplayHandlerFactoryTestHelper deswizzleBuildDisplayHandler];
    [super tearDown];
}

- (void)testIsOfCorrectProtocols {
    XCTAssertTrue([CreateLocationViewController conformsToProtocol:@ protocol(LunchUpdateHandler)]);
    XCTAssertTrue([CreateLocationViewController conformsToProtocol:@ protocol(LocationCreationHandler)]);
}


- (void)testCreateLocationButtonTakesInformationFromTextFieldsAndPassesItToWriter {

    CreateLocationSubController *destinationViewController = [[CreateLocationSubController alloc] init];
    UITextField *addressField = [[UITextField alloc] init];
    UITextField *nameField = [[UITextField alloc] init];
    UITextField *zipcodeField = [[UITextField alloc] init];
    destinationViewController.addressTextField = addressField;
    destinationViewController.nameTextField = nameField;
    destinationViewController.zipCodeTextField = zipcodeField;
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"createLocationSubController" source:self.viewController destination:destinationViewController];

    [self.viewController prepareForSegue:segue sender:nil];

    MockLocationWriter *locationWriter = [[MockLocationWriter alloc] init];
    [LocationWriterFactoryTestHelper setLocationWriterToReturn:locationWriter];

    NSString *expectedName = @"The Is the Name";
    NSString *expectedAddress = @"12345 Address Str";
    NSString *expectedZipCode = @"35234";
    destinationViewController.addressTextField.text = expectedAddress;
    destinationViewController.nameTextField.text = expectedName;
    destinationViewController.zipCodeTextField.text = expectedZipCode;

    [self.viewController createLocationPressed:nil];
    XCTAssertEqualObjects(self.viewController, [LocationWriterFactoryTestHelper getLocationCreationHandlerUsedToBuildWriter]);

    XCTAssertEqualObjects(expectedName, [locationWriter getNameForCreate]);
    XCTAssertEqualObjects(expectedAddress, [locationWriter getAddressForCreate]);
    XCTAssertEqualObjects(expectedZipCode, [locationWriter getZipCodeForCreate]);
}

- (void)testLocationSavedWillUpdateLunchWithLocation {
    MockLunchUpdater *lunchUpdater = [[MockLunchUpdater alloc] init];
    [LunchUpdaterFactoryTestHelper setLunchUpdaterToReturn:lunchUpdater];

    Location *location = [[Location alloc] init];
    Lunch *lunch = [[Lunch alloc] init];
    self.viewController.lunch = lunch;
    [self.viewController locationSaved:location];

    XCTAssertEqualObjects(self.viewController, [LunchUpdaterFactoryTestHelper getLunchUpdateHandlerUsedToBuild]);
    XCTAssertEqualObjects(location, [lunchUpdater getLocationForUpdate]);
    XCTAssertEqualObjects(lunch, [lunchUpdater getLunchForUpdate]);
}

- (void)testHandleLunchUpdatedWillPopUpToRoot {
    MockNavigationController *navController = [[MockNavigationController alloc] init];
    [navController pushViewController:self.viewController animated:true];
    [self.viewController handleLunchUpdate];
    XCTAssertTrue([navController wasPopToRootCalled]);
}

- (void)testLocationSaveFailureWillShowErrorMessage {
    MockDisplayHandler *handler = [[MockDisplayHandler alloc] init];
    [DisplayHandlerFactoryTestHelper setDisplayHandlerToBuild:handler];
    [self.viewController locationSaveError];
    XCTAssertTrue([handler wasShowCommunicationErrorCalled]);
}
- (void)testUpdateLunchFailureWillShowErrorMessage {
    MockDisplayHandler *handler = [[MockDisplayHandler alloc] init];
    [DisplayHandlerFactoryTestHelper setDisplayHandlerToBuild:handler];
    [self.viewController handleLunchUpdateFailed];
    XCTAssertTrue([handler wasShowCommunicationErrorCalled]);
}
@end