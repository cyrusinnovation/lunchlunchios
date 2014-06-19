//
// Created by Cyrus on 5/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//
#import <XCTest/XCTest.h>
#import "DirectionsProvider.h"
#import "DirectionsProviderProtocol.h"
#import "MockDirectionHandler.h"
#import "MockConnectionFactory.h"
#import "Location.h"

@interface DirectionsProviderTest : XCTestCase
@end

@implementation DirectionsProviderTest {

}
- (void)testIsANSURLConnectionDataDelegate {
    XCTAssertTrue([DirectionsProvider conformsToProtocol:@ protocol(NSURLConnectionDataDelegate)]);
    XCTAssertTrue([DirectionsProvider conformsToProtocol:@ protocol(DirectionsProviderProtocol)]);
}

- (void)testCanGetArgumentsFromInit {
    MockDirectionHandler *handler = [[MockDirectionHandler alloc] init];
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    DirectionsProvider *provider =
            [[DirectionsProvider alloc] initWithConnectionFactory:factory andDirectionHandler:handler];
    XCTAssertEqual(handler, [provider getDirectionHandler]);
    XCTAssertEqual(factory, [provider getConnectionFactory]);

}

- (void)testFindDirectionsWillCallGoogleMapAPI {
    MockDirectionHandler *handler = [[MockDirectionHandler alloc] init];
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    DirectionsProvider *provider =
            [[DirectionsProvider alloc] initWithConnectionFactory:factory andDirectionHandler:handler];
    NSString *address = @"2592 Someplace st";
    NSString *zipCode = @"41923";
    Location *destination = [[Location alloc] initWithName:@"name" address:address andZipCode:zipCode];
    double latitude = 3523.2;
    double longitude = 345.5;
    NSDate *date = [NSDate date];
    CLLocation *origin = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    [provider findDirectionsTo:destination fromOrigin:origin];
    NSMutableString *expectedURL = [[NSMutableString alloc] init];
    [expectedURL appendString:@"http://maps.googleapis.com/maps/api/directions/json?sensor=true"];
    [expectedURL appendFormat:@"&origin=%f,%f", latitude, longitude];
    [expectedURL appendString:@"&destination="];
    [expectedURL appendString:address];
    [expectedURL appendString:@","];
    [expectedURL appendString:zipCode];
    [expectedURL appendFormat:@"&departure_time=%.0f",[date timeIntervalSince1970]];
    [expectedURL appendString:@"&mode=transit"];


    NSString *url = [factory getRequestURLPassedInForGet];
    XCTAssertEqualObjects([expectedURL
            stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding], url);
    XCTAssertEqualObjects(provider, [factory getDelegatePassedInForGet]);
}

-(void) testDidFailWithErrorWillInformHandler{
    MockDirectionHandler *handler = [[MockDirectionHandler alloc] init];
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    DirectionsProvider *provider =
            [[DirectionsProvider alloc] initWithConnectionFactory:factory andDirectionHandler:handler];
    [provider connection:nil didFailWithError:nil];

    XCTAssertTrue([handler handleDirectionFailedCalled]);

}
@end