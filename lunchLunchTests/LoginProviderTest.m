//
// Created by Cyrus on 4/2/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LoginProvider.h"
#import "Person.h"

#import "NullPerson.h"
#import "MockConnectionFactory.h"
#import "MockPersonParser.h"
#import "MockPersonReceiver.h"

@interface LoginProviderTest : XCTestCase

@end

@implementation LoginProviderTest {

}

- (void)testIsANSURLConnectionDataDelegate {
    XCTAssertTrue([LoginProvider conformsToProtocol:@protocol(NSURLConnectionDataDelegate)]);
    XCTAssertTrue([LoginProvider conformsToProtocol:@protocol(LoginProviderProtocol)]);
}

- (void)testCanGetArgumentsFromInit {
    MockPersonReceiver *receiver = [[MockPersonReceiver alloc] init];
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockPersonParser *parser = [[MockPersonParser alloc] init];
    LoginProvider *provider =
            [[LoginProvider alloc] initWithConnectionFactory:factory personParser:parser andPersonReceiver:receiver];
    XCTAssertEqual(receiver, [provider getPersonReceiver]);
    XCTAssertEqual(factory, [provider getConnectionFactory]);
    XCTAssertEqual(parser, [provider getPersonParser]);

}

- (void)testFindPersonByEmailWillCreateConnectionUsingFactory {
    MockConnectionFactory *connectionFactory = [[MockConnectionFactory alloc] init];
    LoginProvider *provider =
            [[LoginProvider alloc] initWithConnectionFactory:connectionFactory personParser:[[MockPersonParser alloc] init] andPersonReceiver:[[MockPersonReceiver alloc] init]];
    NSString *email = @"dvfsdfdlkfsd@dfksadf.com";
    [provider findPersonByEmail:email];

    NSString *expectedURL = [NSString stringWithFormat:@"http://localhost:3000/login?email=%@", email];
    XCTAssertEqualObjects(expectedURL, [connectionFactory getRequestURLPassedInForGet]);
    XCTAssertEqual(provider, [connectionFactory getDelegatePassedInForGet]);
}

- (void)testDidFailWithErrorWillCallErrorOnPersonReciever {
    MockPersonReceiver *receiver = [[MockPersonReceiver alloc] init];
    LoginProvider *provider =
            [[LoginProvider alloc] initWithConnectionFactory:[[MockConnectionFactory alloc] init] personParser:[[MockPersonParser alloc] init] andPersonReceiver:receiver];
    [provider connection:nil didFailWithError:nil];
    XCTAssertTrue([receiver wasHandlePersonErrorCalled]);
}

- (void)testConnectionDidFinishLoadingWillGivePersonParsedFromTheDataFromTheConnectionToThePersonReceiver {
    MockPersonReceiver *receiver = [[MockPersonReceiver alloc] init];
    MockPersonParser *parser = [[MockPersonParser alloc] init];
    Person *expectedPerson = [[Person alloc] init];
    [parser setPersonToReturn:expectedPerson];
    LoginProvider *provider =
            [[LoginProvider alloc] initWithConnectionFactory:[[MockConnectionFactory alloc] init] personParser:parser andPersonReceiver:receiver];
    [provider connection:nil didReceiveResponse:nil];
    NSData *dataPacket1 = [[NSData alloc] initWithBase64EncodedString:@"dfushasiuhd" options:0];
    NSData *dataPacket2 = [[NSData alloc] initWithBase64EncodedString:@"fgdfsa" options:0];
    [provider connection:nil didReceiveData:dataPacket1];
    [provider connection:nil didReceiveData:dataPacket2];

    NSMutableData *expectedData = [[NSMutableData alloc] init];
    [expectedData appendData:dataPacket1];
    [expectedData appendData:dataPacket2];

    [provider connectionDidFinishLoading:nil];

    XCTAssertEqualObjects(expectedData, [parser getPersonDataPassedIn]);
    XCTAssertEqual(expectedPerson, [receiver getPersonPassedIn]);


}
@end