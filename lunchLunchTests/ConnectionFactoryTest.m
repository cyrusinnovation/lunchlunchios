//
// Created by Cyrus on 4/16/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//



#import <XCTest/XCTest.h>
#import "ConnectionFactoryProtocol.h"
#import "ConnectionFactory.h"
#import "MockNSURLConnectionDelegate.h"
#import "UIApplicationTestHelper.h"

@interface ConnectionFactoryTest : XCTestCase
@end
@implementation ConnectionFactoryTest {

}
- (void)setUp {
    [super setUp];
    [UIApplicationTestHelper swizzleOpenURL];

}

- (void)tearDown {
    [UIApplicationTestHelper deswizzleOpenURL];
    [super tearDown];
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

    XCTAssertEqualObjects(@"794a8e8f-9654-40cb-a576-635462307c37",  [[request allHTTPHeaderFields] objectForKey:@"api_key"]);

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
    XCTAssertEqualObjects(@"794a8e8f-9654-40cb-a576-635462307c37",  [[request allHTTPHeaderFields] objectForKey:@"api_key"]);
    NSString *expectedDataLength = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];

    XCTAssertEqualObjects(expectedDataLength,  [[request allHTTPHeaderFields] objectForKey:@"Content-Length"]);
    XCTAssertEqualObjects(data, [request HTTPBody]);
    XCTAssertTrue([[request URL] isKindOfClass:[NSURL class]]);

    NSURL *requestURL = [request URL];
    XCTAssertEqual(expectedURL, [requestURL absoluteString]);
}
-(void) testPutData{
    ConnectionFactory *factory = [ConnectionFactory singleton];
    NSString *expectedURL = @"someplace/stuff/dobo";
    MockNSURLConnectionDelegate *delegate = [[MockNSURLConnectionDelegate alloc]init];

    NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"some", @"key1", @"stuff", @"key2", @"123",@"key3",nil];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];

    NSURLConnection *connection = [factory putData:data toURL:expectedURL withDelegate:delegate];

    XCTAssertTrue([[connection currentRequest] isKindOfClass:[NSMutableURLRequest class]]);

    NSURLRequest *request = [connection currentRequest];
    XCTAssertEqualObjects(@"PUT",  [request HTTPMethod]);
    XCTAssertEqualObjects(@"application/json",  [[request allHTTPHeaderFields] objectForKey:@"Content-Type"]);
    XCTAssertEqualObjects(@"794a8e8f-9654-40cb-a576-635462307c37",  [[request allHTTPHeaderFields] objectForKey:@"api_key"]);

    NSString *expectedDataLength = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];

    XCTAssertEqualObjects(expectedDataLength,  [[request allHTTPHeaderFields] objectForKey:@"Content-Length"]);
    XCTAssertEqualObjects(data, [request HTTPBody]);
    XCTAssertTrue([[request URL] isKindOfClass:[NSURL class]]);

    NSURL *requestURL = [request URL];
    XCTAssertEqual(expectedURL, [requestURL absoluteString]);
}
-(void) testOpenURL{
    ConnectionFactory *factory = [ConnectionFactory singleton];
    NSString *expectedURL = @"go/here/jerk";

    [factory openURL:expectedURL];

    XCTAssertEqualObjects(expectedURL,[[UIApplicationTestHelper getURLOpened] absoluteString] );

}
@end