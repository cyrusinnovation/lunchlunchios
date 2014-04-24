//
// Created by Cyrus on 4/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//




#import <XCTest/XCTest.h>
#import "AlertBuilder.h"

@interface AlertBuilderTest : XCTestCase
@end

@implementation AlertBuilderTest {

}

- (void)testIsOfCorrectProtocol {
    XCTAssertTrue([AlertBuilder conformsToProtocol:@protocol(AlertBuilderProtocol)]);
}

- (void)testSingleton {

    XCTAssertNotNil([AlertBuilder singleton]);
    XCTAssertEqual([AlertBuilder singleton], [AlertBuilder singleton]);
}


- (void)testBuildsUIAlertView {

    NSString *expectedTitle = @"I'm the title";
    NSString *expectedMessage = @"I'm the message";
    NSString *expectedButtonText = @"push me yo";
    UIAlertView *view = [[AlertBuilder singleton] buildAlert:expectedTitle message:expectedMessage buttonTitle:expectedButtonText];

    XCTAssertNotNil(view);
    XCTAssertEqualObjects(expectedTitle, [view title]);
    XCTAssertEqualObjects(expectedMessage, [view message]);
    XCTAssertEqualObjects(expectedButtonText, [view buttonTitleAtIndex:0]);
    XCTAssertEqual(0, [view cancelButtonIndex]);
    XCTAssertEqual(1, [view numberOfButtons]);

}
@end