//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//



#import <XCTest/XCTest.h>
#import "LocationDetailViewController.h"
#import "Location.h"
#import "LocationDetailTableViewController.h"

@interface LocationDetailViewControllerTest : XCTestCase
@property(nonatomic, strong) LocationDetailViewController *viewController;
@end
@implementation LocationDetailViewControllerTest {

}
- (void)setUp {
    [super setUp];
    self.viewController = [[LocationDetailViewController alloc] init];



}

- (void)tearDown {

    self.viewController = nil;
    [super tearDown];
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

@end