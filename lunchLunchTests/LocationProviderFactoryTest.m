//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LocationProviderProtocol.h"
#import "LocationProviderFactory.h"
#import "LocationProvider.h"
#import "ConnectionFactory.h"
#import "LocationParser.h"
#import "MockLocationReceiver.h"

@interface LocationProviderFactoryTest : XCTestCase
@end

@implementation LocationProviderFactoryTest {

}
-(void) testBuildLocationProvider{
    MockLocationReceiver *receiver = [[MockLocationReceiver alloc] init];
    NSObject <LocationProviderProtocol> *provider = [LocationProviderFactory buildLocationProvider:receiver];
    XCTAssertTrue([provider isKindOfClass:[LocationProvider class]]);
    LocationProvider *actualProvider = (LocationProvider *) provider;
    XCTAssertEqualObjects([ConnectionFactory singleton], [actualProvider getConnectionFactory]);
    XCTAssertEqualObjects([LocationParser singleton], [actualProvider getLocationParser]);
    XCTAssertEqualObjects(receiver, [actualProvider getLocationReceiver]);
}
@end