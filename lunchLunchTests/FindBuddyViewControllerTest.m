//
// Created by Cyrus on 4/21/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "FoundBuddyViewController.h"
#import "PersonReceiverProtocol.h"
#import "Person.h"
#import "BuddyDetailViewController.h"

@interface FindBuddyViewControllerTest : XCTestCase
@property(nonatomic, strong) FoundBuddyViewController *viewController;
@end
@implementation FindBuddyViewControllerTest {


}

- (void)setUp {
    [super setUp];
    self.viewController = [[FoundBuddyViewController alloc] init];

}

- (void)tearDown {
    self.viewController=    nil;
    [super tearDown];
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

@end