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
    NSURLConnection *connection = [factory buildAsynchronousGetRequestForURL:expectedURL andDelegate:delegate];

    XCTAssertTrue([[connection currentRequest] isKindOfClass:[NSURLRequest class]]);

    NSURLRequest *request = [connection currentRequest];
    XCTAssertEqualObjects(@"GET",  [request HTTPMethod]);
    XCTAssertTrue([[request URL] isKindOfClass:[NSURL class]]);

    NSURL *requestURL = [request URL];
    XCTAssertEqual(expectedURL, [requestURL absoluteString]);

}

-(void) testPostData{
    ConnectionFactory *factory = [ConnectionFactory singleton];
    NSString *expectedURL = @"someplace/stuff/dobo";
    MockNSURLConnectionDelegate *delegate = [[MockNSURLConnectionDelegate alloc]init];

    NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"some", @"key1", @"stuff", @"key2", @"123",@"key3",nil];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];

    NSURLConnection *connection = [factory postData:data toURL:expectedURL withDelegate:delegate];

    XCTAssertTrue([[connection currentRequest] isKindOfClass:[NSMutableURLRequest class]]);

    NSURLRequest *request = [connection currentRequest];
    XCTAssertEqualObjects(@"POST",  [request HTTPMethod]);
    XCTAssertEqualObjects(@"application/json",  [[request allHTTPHeaderFields] objectForKey:@"Content-Type"]);
    NSString *expectedDataLength = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];

    XCTAssertEqualObjects(expectedDataLength,  [[request allHTTPHeaderFields] objectForKey:@"Content-Length"]);
    XCTAssertEqualObjects(data, [request HTTPBody]);
    XCTAssertTrue([[request URL] isKindOfClass:[NSURL class]]);

    NSURL *requestURL = [request URL];
    XCTAssertEqual(expectedURL, [requestURL absoluteString]);

}
@end