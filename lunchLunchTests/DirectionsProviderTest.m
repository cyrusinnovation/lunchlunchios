//
// Created by Cyrus on 5/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//
#import <XCTest/XCTest.h>
#import "DirectionsProvider.h"
#import "DirectionsProviderProtocol.h"
#import "MockConnectionFactory.h"
#import "Location.h"
#import "UIApplicationTestHelper.h"

@interface DirectionsProviderTest : XCTestCase
@end

@implementation DirectionsProviderTest {

}

- (void)setUp {
    [super setUp];
    [UIApplicationTestHelper swizzleCanOpenURL];
}

- (void)tearDown {
    [UIApplicationTestHelper deswizzleCanOpenURL];
    [super tearDown];
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
- (void)testFindDirectionsWillOpenGoogleAppIfItCanOpenTheGoogleMapsApp {

    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    DirectionsProvider *provider =
            [[DirectionsProvider alloc] initWithConnectionFactory:factory];
    NSString *address = @"2592 Someplace st";
    NSString *zipCode = @"41923";
    Location *destination = [[Location alloc] initWithId:nil name:@"name" address:address andZipCode:zipCode];
    double latitude = 3523.2;
    double longitude = 345.5;
    CLLocation *origin = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];

    [UIApplicationTestHelper setCanOpenURL:true];

    [provider findDirectionsTo:destination fromOrigin:origin];

    NSMutableString *expectedURL = [[NSMutableString alloc] init];
    [expectedURL appendString:@"comgooglemaps-x-callback://?"];
    [expectedURL appendFormat:@"&saddr=%f,%f", latitude, longitude];
    [expectedURL appendString:@"&daddr="];
    [expectedURL appendString:address];
    [expectedURL appendString:@","];
    [expectedURL appendString:zipCode];
    [expectedURL appendString:@"&directionsmode=transit"];

    NSString *url = [factory getURLOpened];
    NSString *checked = [[UIApplicationTestHelper getUrlChecked] absoluteString];

    XCTAssertEqualObjects(@"comgooglemaps-x-callback://", checked);
    XCTAssertEqualObjects([expectedURL
            stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding], url);
}

- (void)testFindDirectionsWillOpenGoogleWebSiteIfItCannotOpenTheGoogleMapsApp {

    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    DirectionsProvider *provider =
            [[DirectionsProvider alloc] initWithConnectionFactory:factory];
    NSString *address = @"2592 Someplace st";
    NSString *zipCode = @"41923";
    Location *destination = [[Location alloc] initWithId:nil name:@"name" address:address andZipCode:zipCode];
    double latitude = 3523.2;
    double longitude = 345.5;
    CLLocation *origin = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];

    [UIApplicationTestHelper setCanOpenURL:false];

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
    NSString *checked = [[UIApplicationTestHelper getUrlChecked] absoluteString];

    XCTAssertEqualObjects(@"comgooglemaps-x-callback://", checked);
    XCTAssertEqualObjects([expectedURL
            stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding], url);
}


@end