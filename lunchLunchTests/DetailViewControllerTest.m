//
// Created by Cyrus on 4/10/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//
#import <XCTest/XCTest.h>
#import "Person.h"
#import "DetailViewController.h"
#import "Lunch.h"
#import "DetailsTableViewController.h"

@interface DetailViewControllerTest : XCTestCase
@property(nonatomic, strong) DetailViewController *viewController;
@end

@implementation DetailViewControllerTest {


}

- (void)setUp {
    [super setUp];
    self.viewController = [[DetailViewController alloc] init];

}

- (void)tearDown {
    self.viewController=    nil;
    [super tearDown];
}

- (void)testWillPassPropertiesToDetailsTableViewControllerOnSegue {
    Person *loggedInPerson = [[Person alloc] init];
    self.viewController.personLoggedIn = loggedInPerson;


    Lunch *lunch = [[[Lunch alloc] initWithPerson1:loggedInPerson person2:[[Person alloc] init] dateTime:[NSDate alloc] andLocation:nil ] init];
    self.viewController.lunch = lunch;
    DetailsTableViewController *destinationViewController = [[DetailsTableViewController alloc] init];
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"detailsTable" source:self.viewController destination:destinationViewController];

    XCTAssertNil(destinationViewController.personLoggedIn);
    XCTAssertNil(destinationViewController.lunch);
    [self.viewController prepareForSegue:segue sender:self.viewController];

    XCTAssertEqual(lunch, destinationViewController.lunch);
    XCTAssertEqual(loggedInPerson, destinationViewController.personLoggedIn);


}
@end