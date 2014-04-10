//
// Created by Cyrus on 4/2/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//
#import <XCTest/XCTest.h>
#import "CommandDispatcher.h"
#import "MockCommand.h"

@interface CommandDispatcherTest : XCTestCase

@end

@implementation CommandDispatcherTest {


}

- (void) testIsOfCorrectProtocol{
    XCTAssertTrue([CommandDispatcher conformsToProtocol:@protocol(CommandDispatcherProtocol)]);
}

-(void) testSingleton{

    XCTAssertNotNil([CommandDispatcher singleton]);
    XCTAssertEqual([CommandDispatcher singleton], [CommandDispatcher singleton]);
}

- (void)testExecuteCommand
{
    CommandDispatcher * dispatcher = [CommandDispatcher singleton];
    MockCommand * command = [[MockCommand alloc] init];

    XCTAssertFalse(command.executeWasCalled);
    [dispatcher executeCommand:command];
    XCTAssertTrue(command.executeWasCalled);
}
@end