//
// Created by Cyrus on 4/21/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MockPersonReceiver.h"
#import "BuddyFinderProtocol.h"
#import "BuddyFinderFactory.h"
#import "BuddyFinder.h"
#import "ConnectionFactory.h"
#import "PersonParser.h"

@interface BuddyFinderFactoryTest : XCTestCase
@end
@implementation BuddyFinderFactoryTest {

}

- (void)testWillBuddyFinderWithCorrectInitArguments {
    MockPersonReceiver *receiver = [[MockPersonReceiver alloc] init];
    NSObject <BuddyFinderProtocol> *provider = [BuddyFinderFactory buildBuddyFinder:receiver];
    XCTAssertTrue([provider isKindOfClass:[BuddyFinder class]]);
    BuddyFinder *actualProvider = (BuddyFinder *) provider;
    XCTAssertEqualObjects([ConnectionFactory singleton], [actualProvider getConnectionFactory]);
    XCTAssertEqualObjects([PersonParser singleton], [actualProvider getPersonParser]);
    XCTAssertEqualObjects(receiver, [actualProvider getPersonReceiver]);
}

@end