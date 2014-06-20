//
// Created by Cyrus on 5/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//
#import <XCTest/XCTest.h>
#import "DirectionsProvider.h"
#import "DirectionsProviderProtocol.h"
#import "MockConnectionFactory.h"
#import "Location.h"

@interface DirectionsProviderTest : XCTestCase
@end

@implementation DirectionsProviderTest {

}
- (void)testIsANSURLConnectionDataDelegate {
    XCTAssertTrue([DirectionsProvider conformsToProtocol:@ protocol(DirectionsProviderProtocol)]);
}

- (void)testCanGetArgumentsFromInit {
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    DirectionsProvider *provider =
            [[DirectionsProvider alloc] initWithConnectionFactory:factory];
    XCTAssertEqual(factory, [provider getConnectionFactory]);

}

- (void)testFindDirectionsWillCallGoogleMapAPI {

    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    DirectionsProvider *provider =
            [[DirectionsProvider alloc] initWithConnectionFactory:factory ];
    NSString *address = @"2592 Someplace st";
    NSString *zipCode = @"41923";
    Location *destination = [[Location alloc] initWithName:@"name" address:address andZipCode:zipCode];
    double latitude = 3523.2;
    double longitude = 345.5;
    CLLocation *origin = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    [provider findDirectionsTo:destination fromOrigin:origin];
    NSMutableString *expectedURL = [[NSMutableString alloc] init];
    [expectedURL appendString:@"http://maps.google.com/maps?"];
    [expectedURL appendFormat:@"&saddr=%f,%f", latitude, longitude];
    [expectedURL appendString:@"&daddr="];
    [expectedURL appendString:address];
    [expectedURL appendString:@","];
    [expectedURL appendString:zipCode];
    [expectedURL appendString:@"&dirflg=r"];

    NSString *url = [factory getURLOpened];
    XCTAssertEqualObjects([expectedURL
            stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding], url);
}


@end