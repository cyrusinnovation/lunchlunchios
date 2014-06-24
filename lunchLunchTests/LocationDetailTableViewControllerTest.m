//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "LocationDetailTableViewController.h"
#import "Location.h"

@interface LocationDetailTableViewControllerTest : XCTestCase
@property(nonatomic, strong) LocationDetailTableViewController *viewController;
@end
@implementation LocationDetailTableViewControllerTest {

}
- (void)setUp {
    [super setUp];
    self.viewController = [[LocationDetailTableViewController alloc] init];
    self.viewController.locationNameLabel = [[UILabel alloc] init];
    self.viewController.locationAddressLabel = [[UILabel alloc] init];
    self.viewController.locationZipCodeLabel = [[UILabel alloc] init];

}

- (void)tearDown {
    self.viewController = nil;
    [super tearDown];
}

- (void)testWillShowLocationDetailsOnViewDidLoad {



    NSString *expectedName = @"Barcade";
    NSString *expectedAddress = @"388 Union Ave";
    NSString *expectedZipCode = @"11211";
    Location *location = [[Location alloc] initWithId:nil name:expectedName address:expectedAddress andZipCode:expectedZipCode];
    self.viewController.location = location;

    [self.viewController viewDidLoad];

    XCTAssertEqualObjects(expectedName, [self.viewController.locationNameLabel text]);
    XCTAssertEqualObjects(expectedAddress, [self.viewController.locationAddressLabel text]);
    XCTAssertEqualObjects(expectedZipCode, [self.viewController.locationZipCodeLabel text]);

}

@end