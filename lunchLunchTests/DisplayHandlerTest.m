//
// Created by Cyrus on 4/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "DisplayHandler.h"
#import "MockAlertBuilder.h"
#import "MockUIAlertView.h"

@interface DisplayHandlerTest : XCTestCase
@end

@implementation DisplayHandlerTest {

}
-(void)testConformsToDisplayHandlerProtocol{
    XCTAssertTrue([DisplayHandler conformsToProtocol:@protocol(DisplayHandlerProtocol)]);
}
-(void) testCanGetInitValues{
    MockAlertBuilder *alertBuilder = [[MockAlertBuilder alloc] init];
    DisplayHandler * handler = [[DisplayHandler alloc] initWithAlertBuilder:alertBuilder];
    XCTAssertEqual(alertBuilder, [handler getAlertBuilder]);
    

}
-(void)testShowCommunicationError{

    MockAlertBuilder *alertBuilder = [[MockAlertBuilder alloc] init];
    MockUIAlertView *mockAlert = [[MockUIAlertView alloc] init];
    [alertBuilder setAlertViewToReturn:mockAlert];
    DisplayHandler * handler = [[DisplayHandler alloc] initWithAlertBuilder:alertBuilder];
    [handler showCommunicationError];
    XCTAssertEqualObjects(@"Communication Error", [alertBuilder getBuiltAlertTitle]);
    XCTAssertEqualObjects(@"OK", [alertBuilder getBuiltAlertButtonTitle]);
    XCTAssertEqualObjects(@"Error communicating with web service, please ensure you are connected to the internet and try again", [alertBuilder getBuiltAlertMessage]);

    XCTAssertTrue([mockAlert wasShowCalled]);
}

-(void)testShowError{

    MockAlertBuilder *alertBuilder = [[MockAlertBuilder alloc] init];
    MockUIAlertView *mockAlert = [[MockUIAlertView alloc] init];
    [alertBuilder setAlertViewToReturn:mockAlert];
    DisplayHandler * handler = [[DisplayHandler alloc] initWithAlertBuilder:alertBuilder];
    NSString *expectedErrorMessage = @"Catastrophic warpcore breach";
    [handler showErrorWithMessage:expectedErrorMessage];
    XCTAssertEqualObjects(@"Error", [alertBuilder getBuiltAlertTitle]);
    XCTAssertEqualObjects(@"OK", [alertBuilder getBuiltAlertButtonTitle]);
    XCTAssertEqualObjects(expectedErrorMessage, [alertBuilder getBuiltAlertMessage]);

    XCTAssertTrue([mockAlert wasShowCalled]);
}
@end