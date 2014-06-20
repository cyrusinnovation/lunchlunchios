//
// Created by Cyrus on 6/20/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "Command.h"
#import "ShowMapCommand.h"
#import "MockViewController.h"
#import "SegueCommand.h"
#import "MockCLLocationManager.h"
#import "MockCLLocationManagerDelegate.h"


@interface ShowMapCommandTest : XCTestCase
@end

@implementation ShowMapCommandTest {

}

- (void)testIsOfCorrectProtocol {
    XCTAssertTrue([ShowMapCommand conformsToProtocol:@ protocol(Command)]);
}

- (void)testInitArguments {
    MockCLLocationManager *mockLocationManager = [[MockCLLocationManager alloc] init];
    MockCLLocationManagerDelegate *mockDelegate = [[MockCLLocationManagerDelegate alloc] init];

    ShowMapCommand *command = [[ShowMapCommand alloc] initWithLocationManager:mockLocationManager andDelegate:mockDelegate];

    XCTAssertEqualObjects(mockLocationManager, [command getLocationManager]);
    XCTAssertEqualObjects(mockDelegate, [command getLocationManagerDelegate]);
}

- (void)testExecute {
    MockCLLocationManager *mockLocationManager = [[MockCLLocationManager alloc] init];
    MockCLLocationManagerDelegate *mockDelegate = [[MockCLLocationManagerDelegate alloc] init];

    ShowMapCommand *command = [[ShowMapCommand alloc] initWithLocationManager:mockLocationManager andDelegate:mockDelegate];
    [command execute];

    XCTAssertEqualObjects(mockDelegate, [mockLocationManager getDelegateSet]);
    XCTAssertTrue([mockLocationManager wasUpdateLocationCalled]);

}
@end