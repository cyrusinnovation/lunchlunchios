//
// Created by Cyrus on 7/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PersonCreator.h"
#import "PersonCreatorProtocol.h"
#import "MockConnectionFactory.h"
#import "MockPersonParser.h"
#import "MockPersonReceiver.h"
#import "Person.h"
#import "NullPerson.h"

@interface PersonCreatorTest : XCTestCase
@end

@implementation PersonCreatorTest {

}

- (void)testIsANSURLConnectionDataDelegate {
    XCTAssertTrue([PersonCreator conformsToProtocol:@ protocol(NSURLConnectionDataDelegate)]);
    XCTAssertTrue([PersonCreator conformsToProtocol:@ protocol(PersonCreatorProtocol)]);
}

- (void)testCanGetTheArgumentsPersonCreatorIsInitializedWith {
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockPersonParser *parser = [[MockPersonParser alloc] init];
    MockPersonReceiver *receiver = [[MockPersonReceiver alloc] init];
    PersonCreator *creator = [[PersonCreator alloc] initWithConnectionFactory:factory personParser:parser andPersonReceiver:receiver];

    XCTAssertEqual(factory, [creator getConnectionFactory]);
    XCTAssertEqual(parser, [creator getPersonParser]);
    XCTAssertEqual(receiver, [creator getPersonReceiver]);

}

- (void)testCreatePerson {
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockPersonParser *parser = [[MockPersonParser alloc] init];
    MockPersonReceiver *receiver = [[MockPersonReceiver alloc] init];
    PersonCreator *creator = [[PersonCreator alloc] initWithConnectionFactory:factory personParser:parser andPersonReceiver:receiver];

    NSString *firstName = @"Roy";
    NSString *lastName = @"Harper";
    NSString *email = @"rharper@yahoo.com";

    NSData *expectedData = [[NSData alloc] initWithBase64EncodedString:@"asdasfasasgsdgsdfsfsdfsdfsdfadfs" options:0];
    [parser setPersonJSONToReturn:expectedData];

    [creator createPersonWithFirstName:firstName lastName:lastName andEmail:email];


    XCTAssertEqual(firstName, [parser getFirstNameForBuild]);
    XCTAssertEqual(lastName, [parser getLastNameForBuild]);
    XCTAssertEqual(email, [parser getEmailForBuild]);
    XCTAssertEqual(expectedData, [factory getDataPassedInToPost]);
    XCTAssertEqualObjects(@"http://localhost:3000/createPerson", [factory getRequestURLPassedInForPost]);
    XCTAssertEqual(creator, [factory getDelegatePassedInForPost]);

}

- (void)testDidFailWithErrorWillCallErrorOnPersonReciever {
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockPersonParser *parser = [[MockPersonParser alloc] init];
    MockPersonReceiver *receiver = [[MockPersonReceiver alloc] init];
    PersonCreator *creator = [[PersonCreator alloc] initWithConnectionFactory:factory personParser:parser andPersonReceiver:receiver];

    [creator connection:nil didFailWithError:nil];
    XCTAssertTrue([receiver wasHandlePersonErrorCalled]);
}

- (void)testConnectionDidFinishLoadingWillGiveLocationParsedFromTheDataFromTheConnectionToTheHandler {
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockPersonParser *parser = [[MockPersonParser alloc] init];
    MockPersonReceiver *receiver = [[MockPersonReceiver alloc] init];
    PersonCreator *creator = [[PersonCreator alloc] initWithConnectionFactory:factory personParser:parser andPersonReceiver:receiver];


    [creator connection:nil didReceiveResponse:nil];
    NSData *dataPacket1 = [[NSData alloc] initWithBase64EncodedString:@"dfushasiuhd" options:0];
    NSData *dataPacket2 = [[NSData alloc] initWithBase64EncodedString:@"fgdfsa" options:0];
    [creator connection:nil didReceiveData:dataPacket1];
    [creator connection:nil didReceiveData:dataPacket2];

    NSMutableData *expectedData = [[NSMutableData alloc] init];
    [expectedData appendData:dataPacket1];
    [expectedData appendData:dataPacket2];

    Person *person = [[Person alloc] init];
    [parser setPersonToReturn:person];
    [creator connectionDidFinishLoading:nil];

    XCTAssertEqualObjects(expectedData, [parser getPersonDataPassedIn]);
    XCTAssertEqual(person, [receiver getPersonPassedIn]);
}
- (void)testConnectionDidFinishLoadingWhenANullPersonIsParsedWillReportError {
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    MockPersonParser *parser = [[MockPersonParser alloc] init];
    MockPersonReceiver *receiver = [[MockPersonReceiver alloc] init];
    PersonCreator *creator = [[PersonCreator alloc] initWithConnectionFactory:factory personParser:parser andPersonReceiver:receiver];


    [creator connection:nil didReceiveResponse:nil];
    NSData *dataPacket1 = [[NSData alloc] initWithBase64EncodedString:@"dfushasiuhd" options:0];
    NSData *dataPacket2 = [[NSData alloc] initWithBase64EncodedString:@"fgdfsa" options:0];
    [creator connection:nil didReceiveData:dataPacket1];
    [creator connection:nil didReceiveData:dataPacket2];

    NSMutableData *expectedData = [[NSMutableData alloc] init];
    [expectedData appendData:dataPacket1];
    [expectedData appendData:dataPacket2];

    [parser setPersonToReturn:[NullPerson singleton] ];
    [creator connectionDidFinishLoading:nil];

    XCTAssertEqualObjects(expectedData, [parser getPersonDataPassedIn]);
    XCTAssertTrue([receiver wasHandlePersonErrorCalled]);

}

@end