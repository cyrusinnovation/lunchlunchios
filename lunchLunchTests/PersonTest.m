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
    NSString *expectedId = @"232353253fsdf";
    Person *dude = [[Person alloc] initWithId:expectedId firstName:expectedFirstName lastName:expectedLastName email:expectedEmail];
    XCTAssertEqualObjects(expectedFirstName, [dude getFirstName]);
    XCTAssertEqualObjects(expectedLastName, [dude getLastName]);
    XCTAssertEqualObjects(expectedEmail, [dude getEmailAddress]);
    XCTAssertEqualObjects(expectedId, [dude getId]);
}

-(void)testEqualsAndHash{
    NSString *originalFirstName = @"Bob";
    NSString *originalLastName = @"Vanderhuge";
    NSString *originalEmail = @"bvhuge@angelfire.com";
    NSString *originalId= @"4634dsf";
    Person *originalPerson = [[Person alloc] initWithId:originalId firstName:originalFirstName lastName:originalLastName email:originalEmail];
    Person *equalDude = [[Person alloc] initWithId:originalId firstName:originalFirstName lastName:originalLastName email:originalEmail];
    Person *notEqualDifferentFirstName = [[Person alloc] initWithId:originalId firstName:@"Brohauser" lastName:originalLastName email:originalEmail];
    Person *notEqualDifferentLastName = [[Person alloc] initWithId:originalId firstName:originalFirstName lastName:@"Adsaon" email:originalEmail];
    Person *notEqualDifferentEmail = [[Person alloc] initWithId:originalId firstName:originalFirstName lastName:originalLastName email:@"someother@someemail.com"];
    Person *notEqualsDifferentId = [[Person alloc] initWithId:@"DIFFERENT!!!!" firstName:originalFirstName lastName:originalLastName email:originalEmail];

    NSArray *notEqualObjects = [NSArray arrayWithObjects:notEqualDifferentFirstName, notEqualDifferentLastName, notEqualDifferentEmail, notEqualsDifferentId, nil];

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
