//
// Created by Cyrus on 4/16/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PersonParserProtocol.h"
#import "PersonParser.h"
#import "Person.h"
#import "NullPerson.h"

@interface PersonParserTest : XCTestCase
@end

@implementation PersonParserTest {

}
- (void)testIsOfCorrectProtocol {
    XCTAssertTrue([PersonParser conformsToProtocol:@protocol(PersonParserProtocol)]);
}

- (void)testSingleton {

    XCTAssertNotNil([PersonParser singleton]);
    XCTAssertEqual([PersonParser singleton], [PersonParser singleton]);
}

- (void)testParsePersonWithJSONData {

    NSString *expectedFirstName = @"Harvey";
    NSString *expectedLastName = @"Bullock";
    NSString *expectedEmail = @"HBull@gcpd.com";
    NSString *expectedId = @"3yk4f3247jkh";
    NSArray *values = [NSArray arrayWithObjects:expectedFirstName, expectedLastName, expectedEmail, expectedId, nil];
    NSArray *keys = [NSArray arrayWithObjects:@"firstName", @"lastName", @"email", @"_id", nil];
    NSDictionary *personDictionary = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    NSData *data = [NSJSONSerialization dataWithJSONObject:personDictionary options:0 error:nil];
    PersonParser *parser = [PersonParser singleton];
    NSObject <PersonProtocol> *parsedPerson = [parser parsePersonUsingJsonData:data];
    XCTAssertTrue([parsedPerson isKindOfClass:[Person class]]);
    Person *actualPerson = (Person *) parsedPerson;
    XCTAssertEqualObjects(expectedFirstName, [actualPerson getFirstName]);
    XCTAssertEqualObjects(expectedLastName, [actualPerson getLastName]);
    XCTAssertEqualObjects(expectedEmail, [actualPerson getEmailAddress]);
    XCTAssertEqualObjects(expectedId, [actualPerson getId]);
}

- (void)testParsePersonWithJSONDictionary {

    NSString *expectedFirstName = @"Crispus";
    NSString *expectedLastName = @"Allen";
    NSString *expectedEmail = @"callen@gcpd.com";
    NSString *expectedId = @"callen@gcpd.com";

    NSDictionary *personDictionary = [NSDictionary dictionaryWithObjectsAndKeys:expectedFirstName, @"firstName", expectedLastName, @"lastName", expectedEmail, @"email", expectedId, @"_id", nil];

    PersonParser *parser = [PersonParser singleton];
    NSObject <PersonProtocol> *parsedPerson = [parser parsePersonUsingDictionary:personDictionary];
    XCTAssertTrue([parsedPerson isKindOfClass:[Person class]]);
    Person *actualPerson = (Person *) parsedPerson;
    XCTAssertEqualObjects(expectedFirstName, [actualPerson getFirstName]);
    XCTAssertEqualObjects(expectedLastName, [actualPerson getLastName]);
    XCTAssertEqualObjects(expectedEmail, [actualPerson getEmailAddress]);
    XCTAssertEqualObjects(expectedId, [actualPerson getId]);
}

- (void)testParsePersonWithData_MissingKeysWillReturnNullPerson {
    NSDictionary *missingFirstNameDictionary = [NSDictionary dictionaryWithObjects:
            [NSArray arrayWithObjects:@"", @"", @"", nil]                  forKeys:[NSArray arrayWithObjects:@"lastName", @"email", @"_id", nil]];
    NSDictionary *missingLastNameDictionary = [NSDictionary dictionaryWithObjects:
            [NSArray arrayWithObjects:@"", @"", @"", nil]                 forKeys:[NSArray arrayWithObjects:@"firstName", @"email", @"_id", nil]];
    NSDictionary *missingEmailDictionary = [NSDictionary dictionaryWithObjects:
            [NSArray arrayWithObjects:@"", @"", @"", nil]              forKeys:[NSArray arrayWithObjects:@"firstName", @"lastName", @"_id", nil]];
    NSDictionary *missingIdDictionary = [NSDictionary dictionaryWithObjects:
            [NSArray arrayWithObjects:@"", @"", @"", nil]           forKeys:[NSArray arrayWithObjects:@"firstName", @"lastName", @"email", nil]];

    [self checkNullPersonWhenMissingKeys:missingFirstNameDictionary];
    [self checkNullPersonWhenMissingKeys:missingLastNameDictionary];
    [self checkNullPersonWhenMissingKeys:missingEmailDictionary];
    [self checkNullPersonWhenMissingKeys:missingIdDictionary];
}

- (void)testBuildPersonJSONString {

    NSString *firstName = @"Renee";
    NSString *lastName = @"Montoya";
    NSString *email = @"rmon@gcpd.com";
    NSString *personId = @"sdf1389djf";
    Person *person = [[Person alloc] initWithFirstNameInitWithId:personId firstName:firstName lastName:lastName email:email];

    NSArray *values = [NSArray arrayWithObjects:firstName, lastName, email,personId, nil];
    NSArray *keys = [NSArray arrayWithObjects:@"firstName", @"lastName", @"email",@"_id", nil];
    NSDictionary *personDictionary = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    NSData *expectedData = [NSJSONSerialization dataWithJSONObject:personDictionary options:0 error:nil];
    NSString *expectedJSON = [[NSString alloc] initWithData:expectedData encoding:NSUTF8StringEncoding];

    PersonParser *parser = [PersonParser singleton];
    NSString *personJson = [parser buildPersonJSONString:person];
    XCTAssertEqualObjects(expectedJSON, personJson);

}

- (void)checkNullPersonWhenMissingKeys:(NSDictionary *)missingFirstNameDictionary {
    NSData *dataMissingFirstName = [NSJSONSerialization dataWithJSONObject:missingFirstNameDictionary options:0 error:nil];
    PersonParser *parser = [PersonParser singleton];
    NSObject <PersonProtocol> *parsedPerson = [parser parsePersonUsingJsonData:dataMissingFirstName];
    XCTAssertEqual([NullPerson singleton], parsedPerson);
}
@end
