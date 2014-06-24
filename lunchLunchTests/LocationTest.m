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

    NSString *locationId =@"523523_dasd$asdf";
    NSString *expectedName = @"VIEN";
    NSString *expectedAddress = @"220 Varick St";
    NSString *expectedZipCode = @"10014";
    Location *location = [[Location alloc] initWithId:locationId name:expectedName address:expectedAddress andZipCode:expectedZipCode];
    XCTAssertEqualObjects(locationId, [location getId]);
    XCTAssertEqualObjects(expectedName, [location getName]);
    XCTAssertEqualObjects(expectedAddress, [location getAddress]);
    XCTAssertEqualObjects(expectedZipCode, [location getZipCode]);

}

-(void)testEqualsAndHash{
    NSString *originalName= @"Le Dog";
    NSString *originalAddress= @"410 E Liberty St";
    NSString *originalZipCode = @"48104";
    NSString *locationId = @"412_vgsd_48104";
    Location *originalLocation = [[Location alloc] initWithId:locationId name:originalName address:originalAddress andZipCode:originalZipCode];
    Location *equalObject = [[Location alloc] initWithId:locationId name:originalName address:originalAddress andZipCode:originalZipCode];
    Location *notEqualDifferentId = [[Location alloc] initWithId:@"64346dc_SAdasd" name:originalName address:originalAddress andZipCode:originalZipCode];
    Location *notEqualDifferentName = [[Location alloc] initWithId:locationId name:@"" address:originalAddress andZipCode:originalZipCode];
    Location *notEqualDifferentAddress = [[Location alloc] initWithId:locationId name:originalName address:@"" andZipCode:originalZipCode];
    Location *notEqualDifferentZip = [[Location alloc] initWithId:locationId name:originalName address:originalAddress andZipCode:@""];
    NSArray *notEqualObjects = [NSArray arrayWithObjects:notEqualDifferentId,notEqualDifferentName, notEqualDifferentAddress, notEqualDifferentZip,  nil];

    XCTAssertTrue([originalLocation isEqual: equalObject]);
    XCTAssertEqual([originalLocation hash], [equalObject hash], "Your hash code for equal objects was not equal, did you forget this part of the implementation?");
    for (NSObject * notEqualObject in notEqualObjects){
        XCTAssertFalse([originalLocation isEqual:notEqualObject]);
        XCTAssertNotEqual([originalLocation hash], [notEqualObject hash]);
    }
}
@end