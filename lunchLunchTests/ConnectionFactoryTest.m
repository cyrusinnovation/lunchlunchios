//
// Created by Cyrus on 4/16/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//



#import <XCTest/XCTest.h>
#import "ConnectionFactoryProtocol.h"
#import "ConnectionFactory.h"
#import "MockNSURLConnectionDelegate.h"

@interface ConnectionFactoryTest : XCTestCase
@end
@implementation ConnectionFactoryTest {

}
- (void)testIsOfCorrectProtocol {
    XCTAssertTrue([ConnectionFactory conformsToProtocol:@protocol(ConnectionFactoryProtocol)]);
}
-(void) testSingleton{

    XCTAssertNotNil([ConnectionFactory singleton]);
    XCTAssertEqual([ConnectionFactory singleton], [ConnectionFactory singleton]);
}

-(void) testBuildAsynchronousConnectionForRequest{
    ConnectionFactory *factory = [ConnectionFactory singleton];
    NSString *expectedURL = @"someplace/stuff/dobo";
    MockNSURLConnectionDelegate *delegate = [[MockNSURLConnectionDelegate alloc]init];
    NSURLConnection *connection = [factory buildAsynchronousRequestForURL:expectedURL andDelegate:delegate];

    XCTAssertTrue([[connection currentRequest] isKindOfClass:[NSURLRequest class]]);


    NSURLRequest *request = [connection currentRequest];
    XCTAssertEqualObjects(@"GET",  [request HTTPMethod]);
    XCTAssertTrue([[request URL] isKindOfClass:[NSURL class]]);

    NSURL *requestURL = [request URL];
    XCTAssertEqual(expectedURL, [requestURL absoluteString]);




}
@end