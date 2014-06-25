//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MockLunchUpdateHandler.h"
#import "LunchUpdaterProtocol.h"
#import "LunchUpdater.h"
#import "LocationParser.h"
#import "ConnectionFactory.h"
#import "LunchUpdaterFactory.h"

@interface LunchUpdaterFactoryTest : XCTestCase
@end
@implementation LunchUpdaterFactoryTest {

}
 - (void)testWillBuildLunchUpdaterWithCorrectInitArguments {
    MockLunchUpdateHandler *handler = [[MockLunchUpdateHandler alloc] init];
    NSObject <LunchUpdaterProtocol> *provider = [LunchUpdaterFactory buildLunchUpdater:handler];
    XCTAssertTrue([provider isKindOfClass:[LunchUpdater class]]);
    LunchUpdater *updater = (LunchUpdater *) provider;
    XCTAssertEqualObjects([ConnectionFactory singleton], [updater getConnectionFactory]);

    XCTAssertEqualObjects(handler, [updater getUpdateHandler]);
}
@end