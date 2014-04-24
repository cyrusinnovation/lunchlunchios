//
// Created by Cyrus on 4/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "MockLunchReceiver.h"
#import "LunchCreatorProtocol.h"
#import "LunchCreatorFactory.h"
#import "LunchCreator.h"
#import "ConnectionFactory.h"
#import "LunchParser.h"
#import "MockLunchCreationHandler.h"

@interface LunchCreatorFactoryTest : XCTestCase
@end

@implementation LunchCreatorFactoryTest {

}  - (void)testWillBuildLunchCreateorWithCorrectInitArguments {
    MockLunchCreationHandler *handler = [[MockLunchCreationHandler alloc] init];
    NSObject <LunchCreatorProtocol> *provider = [LunchCreatorFactory buildLunchCreator:handler];
    XCTAssertTrue([provider isKindOfClass:[LunchCreator class]]);
    LunchCreator *actualProvider = (LunchCreator *) provider;
    XCTAssertEqualObjects([ConnectionFactory singleton], [actualProvider getConnectionFactory]);
    XCTAssertEqualObjects([LunchParser singleton], [actualProvider getLunchParser]);
    XCTAssertEqualObjects(handler, [actualProvider getLunchCreationHandler]);
}
@end