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
    NSString *expectedId = @"3423rfdsr";
    NSDictionary *locationDictionary = [NSDictionary dictionaryWithObjectsAndKeys:expectedName, @"name", expectedAddress, @"address", expectedZipCode, @"zipCode", expectedId, @"_id", nil];

    LocationParser *parser = [LocationParser singleton];
    NSObject <LocationProtocol> *parsedLocation = [parser parseLocationUsingDictionary:locationDictionary];
    XCTAssertTrue([parsedLocation isKindOfClass:[Location class]]);
    Location *location = (Location *) parsedLocation;
    XCTAssertEqualObjects(expectedName, [location getName]);
    XCTAssertEqualObjects(expectedAddress, [location getAddress]);
    XCTAssertEqualObjects(expectedZipCode, [location getZipCode]);
    XCTAssertEqualObjects(expectedId, [location getId]);

}

- (void)testParseLocation_MissingKeysWillReturnNullLocation {
    NSDictionary *missingName = [NSDictionary dictionaryWithObjects:
            [NSArray arrayWithObjects:@"", @"",@"", nil]        forKeys:[NSArray arrayWithObjects:@"address", @"zipCode", @"_id", nil]];
    NSDictionary *missingAddress = [NSDictionary dictionaryWithObjects:
            [NSArray arrayWithObjects:@"", @"",@"", nil]           forKeys:[NSArray arrayWithObjects:@"name", @"zipCode",  @"_id", nil]];
    NSDictionary *missingZipCode = [NSDictionary dictionaryWithObjects:
            [NSArray arrayWithObjects:@"", @"",@"", nil]           forKeys:[NSArray arrayWithObjects:@"name", @"address",  @"_id", nil]];
    NSDictionary *missingId = [NSDictionary dictionaryWithObjectsAndKeys:@"namedasdas", @"name", @"adsdasd", @"address", @"asdfasczx2112", @"zipCode",  nil];


    XCTAssertEqual([NullLocation singleton], [[LocationParser singleton] parseLocationUsingDictionary:missingName]);
    XCTAssertEqual([NullLocation singleton], [[LocationParser singleton] parseLocationUsingDictionary:missingAddress]);
    XCTAssertEqual([NullLocation singleton], [[LocationParser singleton] parseLocationUsingDictionary:missingZipCode]);
    XCTAssertEqual([NullLocation singleton], [[LocationParser singleton] parseLocationUsingDictionary:missingId]);

}

- (void)testParseLocations {
    Location *expectedLocation1 = [[Location alloc] initWithId:@"51241" name:@"Ashley's" address:@"338 S State St" andZipCode:@"48104"];
    Location *expectedLocation2 = [[Location alloc] initWithId:@"5df3fsd" name:@"Kosmos" address:@"407 N 5th Ave" andZipCode:@"48104"];

    NSDictionary *locationDictionary1 = [self buildLocationDictionary:expectedLocation1];
    NSDictionary *locationDictionary2 = [self buildLocationDictionary:expectedLocation2];


    NSArray *arrayOfLocations = [NSArray arrayWithObjects:locationDictionary1, locationDictionary2, nil];

    NSData *data = [NSJSONSerialization dataWithJSONObject:arrayOfLocations options:NSJSONWritingPrettyPrinted error:nil];
    NSArray *allLocations = [[LocationParser singleton] parseLocationList:data];
    XCTAssertEqual(2, [allLocations count]);
    XCTAssertEqualObjects(expectedLocation1, [allLocations objectAtIndex:0]);
    XCTAssertEqualObjects(expectedLocation2, [allLocations objectAtIndex:1]);

}

- (void)testParseLocations_WillNotRetainIncompleteLocations {
    Location *expectedLocation1 = [[Location alloc] initWithId:@"2235" name:@"Ashley's" address:@"338 S State St" andZipCode:@"48104"];
    Location *expectedLocation2 = [[Location alloc] initWithId:@"fdgh2345" name:@"Kosmos" address:@"407 N 5th Ave" andZipCode:@"48104"];

    NSDictionary *locationDictionary1 = [self buildLocationDictionary:expectedLocation1];
    NSDictionary *locationDictionary2 = [self buildLocationDictionary:expectedLocation2];

    NSDictionary *missingName = [NSDictionary dictionaryWithObjects:
            [NSArray arrayWithObjects:@"", @"",@"", nil]        forKeys:[NSArray arrayWithObjects:@"address", @"zipCode",  @"_id", nil]];
    NSDictionary *missingAddress = [NSDictionary dictionaryWithObjects:
            [NSArray arrayWithObjects:@"", @"",@"", nil]           forKeys:[NSArray arrayWithObjects:@"name", @"zipCode",  @"_id", nil]];
    NSDictionary *missingZipCode = [NSDictionary dictionaryWithObjects:
            [NSArray arrayWithObjects:@"", @"",@"", nil]           forKeys:[NSArray arrayWithObjects:@"name", @"address",  @"_id", nil]];
    NSDictionary *missingId = [NSDictionary dictionaryWithObjectsAndKeys:@"namedasdas", @"name", @"adsdasd", @"address", @"asdfasczx2112", @"zipCode",  nil];


    NSArray *arrayOfLocations = [NSArray arrayWithObjects:locationDictionary1, locationDictionary2,missingAddress,missingName, missingId, missingZipCode, nil];

    NSData *data = [NSJSONSerialization dataWithJSONObject:arrayOfLocations options:NSJSONWritingPrettyPrinted error:nil];
    NSArray *allLunches = [[LocationParser singleton] parseLocationList:data];
    XCTAssertEqual(2, [allLunches count]);
    XCTAssertEqualObjects(expectedLocation1, [allLunches objectAtIndex:0]);
    XCTAssertEqualObjects(expectedLocation2, [allLunches objectAtIndex:1]);

}


- (NSDictionary *)buildLocationDictionary:(Location *)location {
    return [NSDictionary dictionaryWithObjectsAndKeys:[location getName], @"name", [location getAddress], @"address", [location getZipCode], @"zipCode", [location getId],@"_id", nil];

}
@end