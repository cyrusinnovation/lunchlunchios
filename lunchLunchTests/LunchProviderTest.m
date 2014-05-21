//
// Created by Cyrus on 4/18/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LunchProviderProtocol.h"
#import "LunchProvider.h"
#import "MockConnectionFactory.h"
#import "MockLunchParser.h"
#import "MockLunchReceiver.h"
#import "MockPersonParser.h"
#import "Person.h"
#import "Lunch.h"

@interface LunchProviderTest : XCTestCase
@end

@implementation LunchProviderTest {



}
- (void)testIsANSURLConnectionDataDelegate {
    XCTAssertTrue([LunchProvider conformsToProtocol:@protocol(NSURLConnectionDataDelegate)]);
    XCTAssertTrue([LunchProvider conformsToProtocol:@protocol(LunchProviderProtocol)]);
}

-(void) testCanGetArgumentsFromInit{
    MockLunchReceiver *receiver = [[MockLunchReceiver alloc] init];
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockLunchParser *lunchParser = [[MockLunchParser alloc] init];
    MockPersonParser *personParser = [[MockPersonParser alloc] init];
    LunchProvider *provider =
            [[LunchProvider alloc] initWithConnectionFactory:factory lunchParser:lunchParser personParser:personParser andLunchReceiver:receiver];
    XCTAssertEqual(receiver, [provider getLunchReceiver]);
    XCTAssertEqual(factory, [provider getConnectionFactory]);
    XCTAssertEqual(personParser, [provider getPersonParser]);
    XCTAssertEqual(lunchParser, [provider getLunchParser]);
}

- (void)testFindLunchesForPersonWillCreateConnectionUsingFactory {
    MockLunchReceiver *receiver = [[MockLunchReceiver alloc] init];
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockLunchParser *lunchParser = [[MockLunchParser alloc] init];
    MockPersonParser *personParser = [[MockPersonParser alloc] init];
    LunchProvider *provider =
            [[LunchProvider alloc] initWithConnectionFactory:factory lunchParser:lunchParser personParser:personParser andLunchReceiver:receiver];
    Person *person = [[Person alloc] initWithId:nil firstName:@"Joe" lastName:@"Smith" email:@"JSmith@somethin.com"];
    NSString *expectedJSON = @"IexpecttheParserToTurnThePersonIntoThis";
    [personParser setPersonJSONToReturn:expectedJSON];

    [provider findLunchesFor:person];

    XCTAssertEqualObjects(person, [personParser getPersonToStringify]);

    NSString *expectedURL = [NSString stringWithFormat:@"http://localhost:3000/getLunches?person=%@", expectedJSON];

    XCTAssertEqualObjects(expectedURL, [factory getRequestURLPassedInForGet]);
    XCTAssertEqual(provider, [factory getDelegatePassedInForGet]);
}


- (void)testDidFailWithErrorWillGiveEmptyLunchArrayToReceiver {
    MockLunchReceiver *receiver = [[MockLunchReceiver alloc] init];
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockLunchParser *lunchParser = [[MockLunchParser alloc] init];
    MockPersonParser *personParser = [[MockPersonParser alloc] init];
    LunchProvider *provider =
            [[LunchProvider alloc] initWithConnectionFactory:factory lunchParser:lunchParser personParser:personParser andLunchReceiver:receiver];
    [provider connection:nil didFailWithError:nil];
    XCTAssertEqual(0, [[receiver getLunchesReceived] count]);

}

- (void)testConnectionDidFinishLoadingWillGivePersonParsedFromTheDataFromTheConnectionToThePersonReceiver {
    MockLunchReceiver *receiver = [[MockLunchReceiver alloc] init];
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockLunchParser *lunchParser = [[MockLunchParser alloc] init];
    MockPersonParser *personParser = [[MockPersonParser alloc] init];
    LunchProvider *provider =
            [[LunchProvider alloc] initWithConnectionFactory:factory lunchParser:lunchParser personParser:personParser andLunchReceiver:receiver];

    [provider connection:nil didReceiveResponse:nil];
    NSArray * lunches =    [NSArray arrayWithObjects:[[Lunch alloc] init], [[Lunch alloc] init],[[Lunch alloc] init],nil];
    [lunchParser setLunchesToReturn:lunches];

    NSData *dataPacket1 = [[NSData alloc] initWithBase64EncodedString:@"dfushasiuhd" options:0];
    NSData *dataPacket2 = [[NSData alloc] initWithBase64EncodedString:@"fgdfsa" options:0];
    NSData *dataPacket3 = [[NSData alloc] initWithBase64EncodedString:@"fwghgads" options:0];
    [provider connection:nil didReceiveData:dataPacket1];
    [provider connection:nil didReceiveData:dataPacket2];
    [provider connection:nil didReceiveData:dataPacket3];

    NSMutableData *expectedData = [[NSMutableData alloc] init];
    [expectedData appendData:dataPacket1];
    [expectedData appendData:dataPacket2];
    [expectedData appendData:dataPacket3];

    [provider connectionDidFinishLoading:nil];

    XCTAssertEqualObjects(expectedData, [lunchParser getLunchDataPassedIn]);
    XCTAssertEqual(lunches, [receiver getLunchesReceived]);


}

@end