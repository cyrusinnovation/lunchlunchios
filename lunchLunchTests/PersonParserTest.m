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
    NSArray *values = [NSArray arrayWithObjects:expectedFirstName, expectedLastName, expectedEmail, nil];
    NSArray *keys = [NSArray arrayWithObjects:@"firstName", @"lastName", @"email", nil];
    NSDictionary *personDictionary = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    NSData *data = [NSJSONSerialization dataWithJSONObject:personDictionary options:0 error:nil];
    PersonParser *parser = [PersonParser singleton];
    NSObject <PersonProtocol> *parsedPerson = [parser parsePersonUsingJsonData:data];
    XCTAssertTrue([parsedPerson isKindOfClass:[Person class]]);
    Person *actualPerson = (Person *) parsedPerson;
    XCTAssertEqualObjects(expectedFirstName, [actualPerson getFirstName]);
    XCTAssertEqualObjects(expectedLastName, [actualPerson getLastName]);
    XCTAssertEqualObjects(expectedEmail, [actualPerson getEmailAddress]);
}

- (void)testParsePersonWithJSONDictionary {

    NSString *expectedFirstName = @"Crispus";
    NSString *expectedLastName = @"Allen";
    NSString *expectedEmail = @"callen@gcpd.com";

//

    NSDictionary * personDictionary = [NSDictionary dictionaryWithObjectsAndKeys:expectedFirstName,@"firstName", expectedLastName,@"lastName", expectedEmail,@"email",nil];

    PersonParser *parser = [PersonParser singleton];
    NSObject <PersonProtocol> *parsedPerson = [parser parsePersonUsingDictionary:personDictionary];
    XCTAssertTrue([parsedPerson isKindOfClass:[Person class]]);
    Person *actualPerson = (Person *) parsedPerson;
    XCTAssertEqualObjects(expectedFirstName, [actualPerson getFirstName]);
    XCTAssertEqualObjects(expectedLastName, [actualPerson getLastName]);
    XCTAssertEqualObjects(expectedEmail, [actualPerson getEmailAddress]);
}

- (void)testParsePersonWithData_MissingKeysWillReturnNullPerson {
    NSDictionary *missingFirstNameDictionary = [NSDictionary dictionaryWithObjects:
            [NSArray arrayWithObjects:@"", @"", nil]                       forKeys:[NSArray arrayWithObjects:@"lastName", @"email", nil]];
    NSDictionary *missingLastNameDictionary = [NSDictionary dictionaryWithObjects:
            [NSArray arrayWithObjects:@"", @"", nil]                      forKeys:[NSArray arrayWithObjects:@"firstName", @"email", nil]];
    NSDictionary *missingEmailDictionary = [NSDictionary dictionaryWithObjects:
            [NSArray arrayWithObjects:@"", @"", nil]                   forKeys:[NSArray arrayWithObjects:@"firstName", @"lastName", nil]];

    [self checkNullPersonWhenMissingKeys:missingFirstNameDictionary];
    [self checkNullPersonWhenMissingKeys:missingLastNameDictionary];
    [self checkNullPersonWhenMissingKeys:missingEmailDictionary];
}

- (void)testBuildPersonJSONString {

    NSString *firstName = @"Renee";
    NSString *lastName = @"Montoya";
    NSString *email = @"rmon@gcpd.com";
    Person *person = [[Person alloc] initWithFirstName:firstName lastName:lastName email:email];

    NSArray *values = [NSArray arrayWithObjects:firstName, lastName, email, nil];
    NSArray *keys = [NSArray arrayWithObjects:@"firstName", @"lastName", @"email", nil];
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