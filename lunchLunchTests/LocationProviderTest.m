//
// Created by Cyrus on 6/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LocationProvider.h"
#import "LocationProviderProtocol.h"
#import "MockConnectionFactory.h"
#import "MockLocationReceiver.h"
#import "MockLocationParser.h"
#import "Location.h"

@interface LocationProviderTest : XCTestCase
@end

@implementation LocationProviderTest {

}
- (void)testIsANSURLConnectionDataDelegate {
    XCTAssertTrue([LocationProvider conformsToProtocol:@protocol(NSURLConnectionDataDelegate)]);
    XCTAssertTrue([LocationProvider conformsToProtocol:@protocol(LocationProviderProtocol)]);
}
- (void)testCanGetArgumentsFromInit {
    MockLocationReceiver *receiver = [[MockLocationReceiver alloc] init];
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockLocationParser *parser = [[MockLocationParser alloc] init];
    LocationProvider *provider =
            [[LocationProvider alloc] initWithConnectionFactory:factory parser:parser andLocationReceiver: receiver];
    XCTAssertEqual(receiver, [provider getLocationReceiver]);
    XCTAssertEqual(factory, [provider getConnectionFactory]);
    XCTAssertEqual(parser, [provider getLocationParser]);
}

- (void)testgetAllLocationsWillCreateConnectionUsingFactory {
    MockLocationReceiver *receiver = [[MockLocationReceiver alloc] init];
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockLocationParser *parser = [[MockLocationParser alloc] init];
    LocationProvider *provider =
            [[LocationProvider alloc] initWithConnectionFactory:factory parser:parser andLocationReceiver: receiver];

    [provider getAllLocations];

    NSString *expectedURL = @"http://localhost:3000/locations";

    XCTAssertEqualObjects(expectedURL, [factory getRequestURLPassedInForGet]);
    XCTAssertEqual(provider, [factory getDelegatePassedInForGet]);
}


- (void)testConnectionDidFinishLoadingWillGiveLunchesParsedFromTheDataFromTheConnectionToTheLocationReceiver {
    MockLocationReceiver *receiver = [[MockLocationReceiver alloc] init];
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockLocationParser *parser = [[MockLocationParser alloc] init];
    LocationProvider *provider =
            [[LocationProvider alloc] initWithConnectionFactory:factory parser:parser andLocationReceiver: receiver];

    [provider connection:nil didReceiveResponse:nil];
    NSArray *locations = [NSArray arrayWithObjects:[[Location alloc] init], [[Location alloc] init], [[Location alloc] init], nil];
    [parser setLocationsToReturn:locations];

    NSData *dataPacket1 = [[NSData alloc] initWithBase64EncodedString:@"dfushasiuhd" options:0];
    NSData *dataPacket2 = [[NSData alloc] initWithBase64EncodedString:@"fgdfsa" options:0];
    NSData *dataPacket3 = [[NSData alloc] initWithBase64EncodedString:@"fwghgads" options:0];
    [provider connection:nil didReceiveData:dataPacket1];
    [provider connection:nil didReceiveData:dataPacket2];
    [provider connection:nil didReceiveData:dataPacket3];

    NSMutableData *expectedData = [[NSMutableData alloc] init];
    [expectedData appendData:dataPacket1];
    [expectedData appendData:dataPacket2];
    [expectedData appendData:dataPacket3];

    [provider connectionDidFinishLoading:nil];

    XCTAssertEqualObjects(expectedData, [parser getLocationDataPassedIn]);
    XCTAssertEqual(locations, [receiver getLocationsFound]);
}



@end