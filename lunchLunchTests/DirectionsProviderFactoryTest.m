//
// Created by Cyrus on 6/20/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "MockConnectionFactory.h"
#import "DirectionsProviderFactory.h"
#import "DirectionsProvider.h"
#import "ConnectionFactory.h"

@interface DirectionsProviderFactoryTest : XCTestCase
@end
@implementation DirectionsProviderFactoryTest {

}

-(void)testBuildDirectionsProvider{
    NSObject <DirectionsProviderProtocol> *provider = [DirectionsProviderFactory buildDirectionProvider];
    XCTAssertTrue([provider isKindOfClass:[DirectionsProvider class]]);
    DirectionsProvider *actualProvider = (DirectionsProvider *) provider;
    XCTAssertEqualObjects([ConnectionFactory singleton], [actualProvider getConnectionFactory]);

}
@end