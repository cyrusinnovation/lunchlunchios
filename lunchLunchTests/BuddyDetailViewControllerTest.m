//
// Created by Cyrus on 4/21/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "Person.h"
#import "BuddyDetailViewController.h"

@interface BuddyDetailViewControllerTest : XCTestCase
@property(nonatomic, strong) BuddyDetailViewController *viewController;
@end

@implementation BuddyDetailViewControllerTest {

}
- (void)setUp {
    [super setUp];
    self.viewController = [[BuddyDetailViewController alloc] init];
    self.viewController.firstNameLabel = [[UILabel alloc] init];
    self.viewController.lastNameLabel = [[UILabel alloc] init];
    self.viewController.emailLabel = [[UILabel alloc] init];
}

- (void)tearDown {
    self.viewController=    nil;
    [super tearDown];
}

- (void)testWillShowLunchDetailsOnViewDidLoad {
    NSString *firstName = @"Brock";
    NSString *lastName = @"Thickneck";
    NSString *email = @"BThick@mstk.net";
    Person *buddyFound = [[Person alloc] initWithFirstNameInitWithId:@"346234" firstName:firstName lastName:lastName email:email];



    self.viewController.buddy = buddyFound;

    [self.viewController viewDidLoad];

    XCTAssertEqualObjects(firstName, [self.viewController.firstNameLabel text]);
    XCTAssertEqualObjects(lastName, [self.viewController.lastNameLabel text]);
    XCTAssertEqualObjects(email, [self.viewController.emailLabel text]);



}
@end