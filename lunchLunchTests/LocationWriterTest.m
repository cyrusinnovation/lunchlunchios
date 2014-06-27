//
// Created by Cyrus on 6/26/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LocationWriter.h"
#import "MockLocationParser.h"
#import "MockLocationCreationHandler.h"
#import "MockConnectionFactory.h"
#import "Location.h"
#import "NullLocation.h"

@interface LocationWriterTest : XCTestCase
@end

@implementation LocationWriterTest {

}
- (void)testIsANSURLConnectionDataDelegate {
    XCTAssertTrue([LocationWriter conformsToProtocol:@ protocol(NSURLConnectionDataDelegate)]);
    XCTAssertTrue([LocationWriter conformsToProtocol:@ protocol(LocationWriterProtocol)]);
}

- (void)testCanGetInitArguments {
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockLocationParser *parser = [[MockLocationParser alloc] init];
    MockLocationCreationHandler *creationHandler = [[MockLocationCreationHandler alloc] init];

    LocationWriter *locationWriter = [[LocationWriter alloc] initWithConnectionFactory:factory parser:parser andCreationHandler:creationHandler];
    XCTAssertEqual(factory, [locationWriter getConnectionFactory]);
    XCTAssertEqual(parser, [locationWriter getLocationParser]);
    XCTAssertEqual(creationHandler, [locationWriter getLocationCreationHandler]);
}

- (void)testCreateLocation {
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockLocationParser *parser = [[MockLocationParser alloc] init];
    MockLocationCreationHandler *creationHandler = [[MockLocationCreationHandler alloc] init];

    LocationWriter *locationWriter = [[LocationWriter alloc] initWithConnectionFactory:factory parser:parser andCreationHandler:creationHandler];

    NSString *name = @"name place";
    NSString *address = @"1234 address way";
    NSString *zipCode = @"41932";

    NSData *expectedData = [[NSData alloc] initWithBase64EncodedString:@"asdasfasasfs" options:0];
    [parser setJSONDataToReturn:expectedData];

    [locationWriter createLocationWithName:name address:address andZipCode:zipCode];

    XCTAssertEqualObjects(name, [parser getNameForFormat]);
    XCTAssertEqualObjects(address, [parser getAddressForFormat]);
    XCTAssertEqualObjects(zipCode, [parser getZipCodeForFormat]);
    XCTAssertEqualObjects(expectedData, [factory getDataPassedInToPost]);
    XCTAssertEqualObjects(locationWriter, [factory getDelegatePassedInForPost]);
    XCTAssertEqualObjects(@"http://localhost:3000/createLocation", [factory getRequestURLPassedInForPost]);
}

- (void)testDidFailWithErrorWillCallErrorOnPersonReciever {
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockLocationParser *parser = [[MockLocationParser alloc] init];
    MockLocationCreationHandler *creationHandler = [[MockLocationCreationHandler alloc] init];

    LocationWriter *locationWriter = [[LocationWriter alloc] initWithConnectionFactory:factory parser:parser andCreationHandler:creationHandler];


    [locationWriter connection:nil didFailWithError:nil];
    XCTAssertTrue([creationHandler wasLocationSaveErrorCalled]);
}

- (void)testConnectionDidFinishLoadingWillGiveLocationParsedFromTheDataFromTheConnectionToTheHandler {
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockLocationParser *parser = [[MockLocationParser alloc] init];
    MockLocationCreationHandler *creationHandler = [[MockLocationCreationHandler alloc] init];

    LocationWriter *locationWriter = [[LocationWriter alloc] initWithConnectionFactory:factory parser:parser andCreationHandler:creationHandler];

    [locationWriter connection:nil didReceiveResponse:nil];
    NSData *dataPacket1 = [[NSData alloc] initWithBase64EncodedString:@"dfushasiuhd" options:0];
    NSData *dataPacket2 = [[NSData alloc] initWithBase64EncodedString:@"fgdfsa" options:0];
    [locationWriter connection:nil didReceiveData:dataPacket1];
    [locationWriter connection:nil didReceiveData:dataPacket2];

    NSMutableData *expectedData = [[NSMutableData alloc] init];
    [expectedData appendData:dataPacket1];
    [expectedData appendData:dataPacket2];

    Location *location = [[Location alloc] init];
    [parser setLocationToReturn:location];
    [locationWriter connectionDidFinishLoading:nil];

    XCTAssertEqualObjects(expectedData, [parser getJSONToParse]);
    XCTAssertEqual(location, [creationHandler getLocationSaved]);
}

- (void)testConnectionDidFinishLoadingIfANullLocationIsParsedWillCallErrorOnTheCreationHandler {
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockLocationParser *parser = [[MockLocationParser alloc] init];
    MockLocationCreationHandler *creationHandler = [[MockLocationCreationHandler alloc] init];

    LocationWriter *locationWriter = [[LocationWriter alloc] initWithConnectionFactory:factory parser:parser andCreationHandler:creationHandler];

    [locationWriter connection:nil didReceiveResponse:nil];
    NSData *dataPacket1 = [[NSData alloc] initWithBase64EncodedString:@"dfushasiuhd" options:0];
    NSData *dataPacket2 = [[NSData alloc] initWithBase64EncodedString:@"fgdfsa" options:0];
    [locationWriter connection:nil didReceiveData:dataPacket1];
    [locationWriter connection:nil didReceiveData:dataPacket2];

    NSMutableData *expectedData = [[NSMutableData alloc] init];
    [expectedData appendData:dataPacket1];
    [expectedData appendData:dataPacket2];

    [parser setLocationToReturn:[NullLocation singleton]];
    [locationWriter connectionDidFinishLoading:nil];

    XCTAssertEqualObjects(expectedData, [parser getJSONToParse]);
    XCTAssertTrue([creationHandler wasLocationSaveErrorCalled]);
}
@end