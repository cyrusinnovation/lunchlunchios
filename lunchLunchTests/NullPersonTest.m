//
// Created by Cyrus on 4/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NullPerson.h"
#import "PersonProtocol.h"


@interface NullPersonTest : XCTestCase
@end

@implementation NullPersonTest {

}
- (void) testIsOfCorrectProtocol{
    XCTAssertTrue([NullPerson conformsToProtocol:@protocol(PersonProtocol)]);
}

-(void) testSingleton{

    XCTAssertNotNil([NullPerson singleton]);
    XCTAssertEqual([NullPerson singleton], [NullPerson singleton]);
}
-(void)testEmptyStringGets{
    XCTAssertEqualObjects(@"", [[NullPerson singleton] getFirstName]);
    XCTAssertEqualObjects(@"", [[NullPerson singleton] getLastName]);
    XCTAssertEqualObjects(@"", [[NullPerson singleton] getEmailAddress]);

}
@end