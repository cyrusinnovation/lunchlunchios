//
// Created by Cyrus on 4/21/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "BuddyFinderProtocol.h"
#import "BuddyFinder.h"
#import "MockPersonReceiver.h"
#import "MockConnectionFactory.h"
#import "MockPersonParser.h"
#import "Person.h"
#import "NullPerson.h"

@interface BuddyFinderTest : XCTestCase
@end
@implementation BuddyFinderTest {

}

- (void)testIsANSURLConnectionDataDelegate {
    XCTAssertTrue([BuddyFinder conformsToProtocol:@protocol(NSURLConnectionDataDelegate)]);
    XCTAssertTrue([BuddyFinder conformsToProtocol:@protocol(BuddyFinderProtocol)]);
}

-(void) testCanGetArgumentsFromInit{
    MockPersonReceiver *receiver = [[MockPersonReceiver alloc] init];
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockPersonParser *parser = [[MockPersonParser alloc] init];
    BuddyFinder *finder =
            [[BuddyFinder alloc] initWithConnectionFactory:factory personParser:parser andPersonReceiver:receiver];
    XCTAssertEqual(receiver, [finder getPersonReceiver]);
    XCTAssertEqual(factory, [finder getConnectionFactory]);
    XCTAssertEqual(parser, [finder getPersonParser]);

}

- (void)testFindBuddyForPersonWillCreateConnectionUsingFactory {
    MockPersonReceiver *receiver = [[MockPersonReceiver alloc] init];
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockPersonParser *parser = [[MockPersonParser alloc] init];
    BuddyFinder *finder =
            [[BuddyFinder alloc] initWithConnectionFactory:factory personParser:parser andPersonReceiver:receiver];
    Person *person = [[Person alloc] initWithId:@"iasdasfas" firstName:@"Joe" lastName:@"Smith" email:@"JSmith@somethin.com"];
    NSString *expectedJSON = @"IexpecttheParserToTurnThePersonIntoThis";
    [parser setPersonJSONToReturn:expectedJSON];

    [finder findBuddyFor:person];

    XCTAssertEqualObjects(person, [parser getPersonToStringify]);

    NSString *expectedURL = [NSString stringWithFormat:@"http://localhost:3000/findBuddy?person=%@", expectedJSON];

    XCTAssertEqualObjects(expectedURL, [factory getRequestURLPassedInForGet]);
    XCTAssertEqual(finder, [factory getDelegatePassedInForGet]);
}

- (void)testDidFailWithErrorCallErrorOnReceiver {

    MockPersonReceiver *receiver = [[MockPersonReceiver alloc] init];
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockPersonParser *parser = [[MockPersonParser alloc] init];
    BuddyFinder *finder =
            [[BuddyFinder alloc] initWithConnectionFactory:factory personParser:parser andPersonReceiver:receiver];
    [finder connection:nil didFailWithError:nil];
    XCTAssertTrue([receiver wasHandlePersonErrorCalled]);
}

- (void)testConnectionDidFinishLoadingWillGivePersonParsedFromTheDataFromTheConnectionToThePersonReceiver {
    MockPersonReceiver *receiver = [[MockPersonReceiver alloc] init];
    MockPersonParser *parser = [[MockPersonParser alloc] init];
    Person *expectedPerson = [[Person alloc] init];
    [parser setPersonToReturn:expectedPerson];
    BuddyFinder *finder =
            [[BuddyFinder alloc] initWithConnectionFactory:[[MockConnectionFactory alloc] init] personParser:parser andPersonReceiver:receiver];

    [finder connection:nil didReceiveResponse:nil];
    NSData *dataPacket1 = [[NSData alloc] initWithBase64EncodedString:@"vcxvxcv" options:0];
    NSData *dataPacket2 = [[NSData alloc] initWithBase64EncodedString:@"fgdfsasdasa" options:0];
    [finder connection:nil didReceiveData:dataPacket1];
    [finder connection:nil didReceiveData:dataPacket2];

    NSMutableData *expectedData = [[NSMutableData alloc] init];
    [expectedData appendData:dataPacket1];
    [expectedData appendData:dataPacket2];

    [finder connectionDidFinishLoading:nil];

    XCTAssertEqualObjects(expectedData, [parser getPersonDataPassedIn]);
    XCTAssertEqual(expectedPerson, [receiver getPersonPassedIn]);


}

@end