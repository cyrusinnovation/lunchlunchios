//
// Created by Cyrus on 6/26/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MockLocationCreationHandler.h"
#import "LocationWriterProtocol.h"
#import "LocationWriterFactory.h"
#import "LunchCreator.h"
#import "ConnectionFactory.h"
#import "LocationWriter.h"
#import "LocationParser.h"

@interface LocationWriterFactoryTest : XCTestCase
@end

@implementation LocationWriterFactoryTest {

}
- (void)testWillBuildLocationWriterWithCorrectInitArguments {
    MockLocationCreationHandler *handler = [[MockLocationCreationHandler alloc] init];
    NSObject <LocationWriterProtocol> *provider = [LocationWriterFactory buildLocationWriter:handler];
    XCTAssertTrue([provider isKindOfClass:[LocationWriter class]]);
    LocationWriter *writer = (LocationWriter *) provider;
    XCTAssertEqualObjects([ConnectionFactory singleton], [writer getConnectionFactory]);
    XCTAssertEqualObjects([LocationParser singleton], [writer getLocationParser]);
    XCTAssertEqualObjects(handler, [writer getLocationCreationHandler]);
}
@end