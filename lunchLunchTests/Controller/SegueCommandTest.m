//
// Created by Cyrus on 4/2/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//
#import <XCTest/XCTest.h>
#import "CommandDispatcher.h"

#import "SegueCommand.h"
#import "MockViewController.h"

@interface SegueCommandTest : XCTestCase

@end

@implementation SegueCommandTest {


}

- (void)testIsOfCorrectProtocol {
    XCTAssertTrue([SegueCommand conformsToProtocol:@protocol(Command)]);
}

- (void)testInitArguments {
    MockViewController *viewController = [[MockViewController alloc] init];
    NSString *segueIdentifier = @"segway!";
    SegueCommand *command = [[SegueCommand alloc] initForViewController:viewController segueIdentifier:segueIdentifier];

    XCTAssertEqualObjects(viewController, [command getViewController]);
    XCTAssertEqualObjects(segueIdentifier, [command getSegueIdentifier]);
}
- (void) testExecute{
    MockViewController *viewController = [[MockViewController alloc] init];
    NSString *segueIdentifier = @"segway!";
    SegueCommand *command = [[SegueCommand alloc] initForViewController:viewController segueIdentifier:segueIdentifier];
    [command execute];

    XCTAssertEqualObjects(viewController, [viewController senderForPerformSegue]);
    XCTAssertEqualObjects(segueIdentifier, [viewController segueToPerform]);


}
@end