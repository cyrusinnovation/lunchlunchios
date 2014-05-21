//
// Created by Cyrus on 5/15/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LocationProtocol.h"
#import "NullLocation.h"

@interface NullLocationTest : XCTestCase
@end

@implementation NullLocationTest {

}
- (void) testIsOfCorrectProtocol{
    XCTAssertTrue([NullLocation conformsToProtocol:@protocol(LocationProtocol)]);
}

-(void) testSingleton{

    XCTAssertNotNil([NullLocation singleton]);
    XCTAssertEqual([NullLocation singleton], [NullLocation singleton]);
}
-(void)testEmptyStringGets{
    XCTAssertEqualObjects(@"", [[NullLocation singleton] getName]);
    XCTAssertEqualObjects(@"", [[NullLocation singleton] getAddress]);
    XCTAssertEqualObjects(@"", [[NullLocation singleton] getZipCode]);
}
@end