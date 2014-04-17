//
// Created by Cyrus on 4/17/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "LoginProviderFactory.h"
#import "MockPersonReceiver.h"
#import "LoginProvider.h"
#import "ConnectionFactory.h"
#import "PersonParser.h"

@interface LoginProviderFactoryTest : XCTestCase
@end

@implementation LoginProviderFactoryTest {

    

}
- (void)testWillBuildLoginProviderWithCorrectInitArguments {
    MockPersonReceiver *receiver = [[MockPersonReceiver alloc] init];
    NSObject <LoginProviderProtocol> *provider = [LoginProviderFactory buildLoginProvider:receiver];
    XCTAssertTrue([provider isKindOfClass:[LoginProvider class]]);
    LoginProvider *actualProvider = (LoginProvider *) provider;
    XCTAssertEqualObjects([ConnectionFactory singleton], [actualProvider getConnectionFactory]);
    XCTAssertEqualObjects([PersonParser singleton], [actualProvider getPersonParser]);
    XCTAssertEqualObjects(receiver, [actualProvider getPersonReceiver]);
}

@end