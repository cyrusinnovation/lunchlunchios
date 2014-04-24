//
// Created by Cyrus on 4/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//



#import <XCTest/XCTest.h>
#import "DisplayHandlerProtocol.h"
#import "DisplayHandlerFactory.h"
#import "BuddyFinder.h"
#import "DisplayHandler.h"
#import "AlertBuilder.h"

@interface DisplayHandlerFactoryTest : XCTestCase
@end

@implementation DisplayHandlerFactoryTest {

}


- (void)testWillBuildDisplayHandlerFinderWithCorrectInitArguments {

    NSObject <DisplayHandlerProtocol> *displayHandler = [DisplayHandlerFactory buildDisplayHandler];
    XCTAssertTrue([displayHandler isKindOfClass:[DisplayHandler class]]);
    DisplayHandler *actualHandler = (DisplayHandler *) displayHandler;
    XCTAssertEqualObjects([AlertBuilder singleton], [actualHandler getAlertBuilder]);

}

- (void)testReturnsTheSameDisplayHandlerEveryTime {

    NSObject <DisplayHandlerProtocol> *displayHandler = [DisplayHandlerFactory buildDisplayHandler];
    XCTAssertEqual(displayHandler, [DisplayHandlerFactory buildDisplayHandler]);

}

@end