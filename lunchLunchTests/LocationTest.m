//
// Created by Cyrus on 5/15/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//



#import <XCTest/XCTest.h>
#import "Location.h"
#import "LocationProtocol.h"

@interface LocationTest : XCTestCase
@end

@implementation LocationTest {

}
- (void)testIsOfCorrectProtocol {
    XCTAssertTrue([Location conformsToProtocol:@protocol(LocationProtocol)]);
}

- (void) testInitAndGetFields{

    NSString *expectedName = @"VIEN";
    NSString *expectedAddress = @"220 Varick St";
    NSString *expectedZipCode = @"10014";
    Location *location = [[Location alloc] initWithName:expectedName address:expectedAddress andZipCode:expectedZipCode];
    XCTAssertEqualObjects(expectedName, [location getName]);
    XCTAssertEqualObjects(expectedAddress, [location getAddress]);
    XCTAssertEqualObjects(expectedZipCode, [location getZipCode]);

}

-(void)testEqualsAndHash{
    NSString *originalName= @"Le Dog";
    NSString *originalAddress= @"410 E Liberty St";
    NSString *originalZipCode = @"48104";
    Location *originalLocation = [[Location alloc] initWithName:originalName address:originalAddress andZipCode:originalZipCode];
    Location *equalObject = [[Location alloc] initWithName:originalName address:originalAddress andZipCode:originalZipCode];
    Location *notEqualDifferentName = [[Location alloc] initWithName:@"" address:originalAddress andZipCode:originalZipCode];
    Location *notEqualDifferentAddress = [[Location alloc] initWithName:originalName address:@"" andZipCode:originalZipCode];
    Location *notEqualDifferentZip = [[Location alloc] initWithName:originalName address:originalAddress andZipCode:@""];
    NSArray *notEqualObjects = [NSArray arrayWithObjects:notEqualDifferentName, notEqualDifferentAddress, notEqualDifferentZip,  nil];

    XCTAssertTrue([originalLocation isEqual: equalObject]);
    XCTAssertEqual([originalLocation hash], [equalObject hash], "Your hash code for equal objects was not equal, did you forget this part of the implementation?");
    for (NSObject * notEqualObject in notEqualObjects){
        XCTAssertFalse([originalLocation isEqual:notEqualObject]);
        XCTAssertNotEqual([originalLocation hash], [notEqualObject hash]);
    }
}
@end