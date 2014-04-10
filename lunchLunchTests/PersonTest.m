//
//  PersonTest.m
//  lunchlunch
//
//  Created by Cyrus on 4/2/14.
//  Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "Person.h"

@interface PersonTest : XCTestCase

@end

@implementation PersonTest
- (void)testIsOfCorrectProtocol {
    XCTAssertTrue([Person conformsToProtocol:@protocol(PersonProtocol)]);
}

- (void)testInitAndGetFields {
    NSString *expectedFirstName = @"Bob";
    NSString *expectedLastName = @"Vanderhuge";
    NSString *expectedEmail = @"bvhuge@angelfire.com";
    Person *dude = [[Person alloc] initWithFirstName:expectedFirstName lastName:expectedLastName email:expectedEmail];
    XCTAssertEqualObjects(expectedFirstName, [dude getFirstName]);
    XCTAssertEqualObjects(expectedLastName, [dude getLastName]);
    XCTAssertEqualObjects(expectedEmail, [dude getEmailAddress]);
}

-(void)testEqualsAndHash{
    NSString *expectedFirstName = @"Bob";
    NSString *expectedLastName = @"Vanderhuge";
    NSString *expectedEmail = @"bvhuge@angelfire.com";
    Person *originalPerson = [[Person alloc] initWithFirstName:expectedFirstName lastName:expectedLastName email:expectedEmail];
    Person *equalDude = [[Person alloc] initWithFirstName:expectedFirstName lastName:expectedLastName email:expectedEmail];
    Person *notEqualDifferentFirstName = [[Person alloc] initWithFirstName:@"Brohauser" lastName:expectedLastName email:expectedEmail];
    Person *notEqualDifferentLastName = [[Person alloc] initWithFirstName:expectedFirstName lastName:@"Adsaon" email:expectedEmail];
    Person *notEqualDifferentEmail = [[Person alloc] initWithFirstName:expectedFirstName lastName:expectedLastName email:@"someother@someemail.com"];

    NSArray *notEqualObjects = [NSArray arrayWithObjects:notEqualDifferentFirstName, notEqualDifferentLastName, notEqualDifferentEmail, nil];

    XCTAssertTrue([originalPerson isEqual:originalPerson]);
    XCTAssertTrue([originalPerson isEqual: equalDude]);
    XCTAssertEqual([originalPerson hash], [originalPerson hash]);
    XCTAssertEqual([originalPerson hash], [equalDude hash], "Your hash code for equal objects was not equal, did you forget this part of the implementation?");
    for (NSObject * notEqualObject in notEqualObjects){
        XCTAssertFalse([originalPerson isEqual:notEqualObject]);
        XCTAssertNotEqual([originalPerson hash], [notEqualObject hash]);
    }



}
@end
