#import <XCTest/XCTest.h>
#import "LocationParser.h"
#import "LocationProtocol.h"
#import "Location.h"
#import "NullLocation.h"

//
// Created by Cyrus on 5/20/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//
@interface LocationParserTest : XCTestCase
@end

@implementation LocationParserTest {


}
- (void)testSingleton {
    XCTAssertNotNil([LocationParser singleton]);
    XCTAssertEqual([LocationParser singleton], [LocationParser singleton]);
}


- (void)testParseLocationWithJSONDictionary {
    NSString *expectedName = @"Go! Go! CURRY!";
    NSString *expectedAddress = @"273 W 38th St";
    NSString *expectedZipCode = @"10018";
    NSDictionary *locationDictionary = [NSDictionary dictionaryWithObjectsAndKeys:expectedName, @"name", expectedAddress, @"address", expectedZipCode, @"zipCode", nil];

    LocationParser *parser = [LocationParser singleton];
    NSObject <LocationProtocol> *parsedLocation = [parser parseLocationUsingDictionary:locationDictionary];
    XCTAssertTrue([parsedLocation isKindOfClass:[Location class]]);
    Location *location = (Location *) parsedLocation;
    XCTAssertEqualObjects(expectedName, [location getName]);
    XCTAssertEqualObjects(expectedAddress, [location getAddress]);
    XCTAssertEqualObjects(expectedZipCode, [location getZipCode]);

}

- (void)testParseLocation_MissingKeysWillReturnNullLocation {
    NSDictionary *missingName = [NSDictionary dictionaryWithObjects:
            [NSArray arrayWithObjects:@"", @"",  nil]                  forKeys:[NSArray arrayWithObjects:@"address", @"zipCode", nil]];
    NSDictionary *missingAddress = [NSDictionary dictionaryWithObjects:
            [NSArray arrayWithObjects:@"", @"",  nil]                 forKeys:[NSArray arrayWithObjects:@"name", @"zipCode", nil]];
    NSDictionary *missingZipCode = [NSDictionary dictionaryWithObjects:
            [NSArray arrayWithObjects:@"", @"", nil]              forKeys:[NSArray arrayWithObjects:@"name", @"address", nil]];

    XCTAssertEqual([NullLocation singleton], [[LocationParser singleton] parseLocationUsingDictionary:missingName]);
    XCTAssertEqual([NullLocation singleton], [[LocationParser singleton] parseLocationUsingDictionary:missingAddress]);
    XCTAssertEqual([NullLocation singleton], [[LocationParser singleton] parseLocationUsingDictionary:missingZipCode]);

}

@end