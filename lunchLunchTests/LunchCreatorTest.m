#import <XCTest/XCTest.h>
#import "LunchCreatorProtocol.h"
#import "LunchCreator.h"
#import "MockLunchReceiver.h"
#import "MockConnectionFactory.h"
#import "MockLunchParser.h"
#import "Lunch.h"
#import "MockLunchCreationHandler.h"

//
// Created by Cyrus on 4/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//
@interface LunchCreatorTest : XCTestCase
@end


@implementation LunchCreatorTest {

}
- (void)testIsANSURLConnectionDataDelegate {
    XCTAssertTrue([LunchCreator conformsToProtocol:@protocol(NSURLConnectionDataDelegate)]);
    XCTAssertTrue([LunchCreator conformsToProtocol:@protocol(LunchCreatorProtocol)]);
}


- (void)testCanGetArgumentsFromInit {
    MockLunchCreationHandler *creationHandler = [[MockLunchCreationHandler alloc] init];
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockLunchParser *lunchParser = [[MockLunchParser alloc] init];
    LunchCreator *creator =
            [[LunchCreator alloc] initWithConnectionFactory:factory lunchParser:lunchParser andLunchCreationHandler:creationHandler];
    XCTAssertEqual(creationHandler, [creator getLunchCreationHandler]);
    XCTAssertEqual(factory, [creator getConnectionFactory]);
    XCTAssertEqual(lunchParser, [creator getLunchParser]);
}

-(void) testCreateLunch{
    MockLunchCreationHandler *creationHandler = [[MockLunchCreationHandler alloc] init];
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockLunchParser *lunchParser = [[MockLunchParser alloc] init];
    LunchCreator *creator =
            [[LunchCreator alloc] initWithConnectionFactory:factory lunchParser:lunchParser andLunchCreationHandler:creationHandler];

    NSObject <LunchProtocol> *lunchToCreate = [[Lunch alloc] init];

    NSData *lunchData = [[NSData alloc] initWithBase64EncodedString:@"dsgddasdasssdfs2r2" options:0];
    [lunchParser setLunchDataToReturn:lunchData ];
    [creator createLunch:lunchToCreate];


    XCTAssertEqual(lunchToCreate, [lunchParser getLunchPassedToBuildJSON]);
    XCTAssertEqual(lunchData, [factory getDataPassedInToPost]);
    XCTAssertEqualObjects(@"http://localhost:3000/createLunch", [factory getRequestURLPassedInForPost]);
    XCTAssertEqual(creator, [factory getDelegatePassedInForPost]);

}


- (void)testDidFailWithError {

    MockLunchCreationHandler *creationHandler = [[MockLunchCreationHandler alloc] init];
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockLunchParser *lunchParser = [[MockLunchParser alloc] init];
    LunchCreator *creator =
            [[LunchCreator alloc] initWithConnectionFactory:factory lunchParser:lunchParser andLunchCreationHandler:creationHandler];
    [creator connection:nil didFailWithError:nil];
    XCTAssertTrue([creationHandler wasHandleLunchCreationFailedCalled]);
}


- (void)testDidFinishLoading {

    MockLunchCreationHandler *creationHandler = [[MockLunchCreationHandler alloc] init];
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockLunchParser *lunchParser = [[MockLunchParser alloc] init];
    LunchCreator *creator =
            [[LunchCreator alloc] initWithConnectionFactory:factory lunchParser:lunchParser andLunchCreationHandler:creationHandler];
    [creator connectionDidFinishLoading:nil];
    XCTAssertTrue([creationHandler wasHandleLunchCreateCalled]);
}


@end