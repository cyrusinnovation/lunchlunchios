//
// Created by Cyrus on 4/18/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//



#import <XCTest/XCTest.h>
#import "MockLunchReceiver.h"
#import "LunchProviderProtocol.h"
#import "LunchProviderFactory.h"
#import "LunchProvider.h"
#import "ConnectionFactory.h"
#import "PersonParser.h"
#import "LunchParser.h"

@interface LunchProviderFactoryTest : XCTestCase
@end


@implementation LunchProviderFactoryTest {

}
- (void)testWillBuildLunchProviderWithCorrectInitArguments {
    MockLunchReceiver *receiver = [[MockLunchReceiver alloc] init];
    NSObject <LunchProviderProtocol> *provider = [LunchProviderFactory buildLunchProvider:receiver];
    XCTAssertTrue([provider isKindOfClass:[LunchProvider class]]);
    LunchProvider *actualProvider = (LunchProvider *) provider;
    XCTAssertEqualObjects([ConnectionFactory singleton], [actualProvider getConnectionFactory]);
    XCTAssertEqualObjects([PersonParser singleton], [actualProvider getPersonParser]);
    XCTAssertEqualObjects([LunchParser singleton], [actualProvider getLunchParser]);
    XCTAssertEqualObjects(receiver, [actualProvider getLunchReceiver]);
}

@end

