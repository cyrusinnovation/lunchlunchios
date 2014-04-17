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
-(void) testSingleton{

    XCTAssertNotNil([PersonParser singleton]);
    XCTAssertEqual([PersonParser singleton], [PersonParser singleton]);
}
- (void)testParsePerson {

    NSString *expectedFirstName = @"Harvey";
    NSString *expectedLastName = @"Bullock";
    NSString *expectedEmail = @"HBull@gcpd.com";
    NSArray *values = [NSArray arrayWithObjects:expectedFirstName, expectedLastName, expectedEmail, nil];
    NSArray *keys = [NSArray arrayWithObjects:@"firstName", @"lastName", @"email", nil];
    NSDictionary *personDictionary = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    NSData *data = [NSJSONSerialization dataWithJSONObject:personDictionary options:0 error:nil];
    PersonParser *parser = [PersonParser singleton];
    NSObject <PersonProtocol> *parsedPerson = [parser parsePerson:data];
    XCTAssertTrue([parsedPerson isKindOfClass:[Person class]]);
    Person *actualPerson = (Person *) parsedPerson;
    XCTAssertEqualObjects(expectedFirstName, [actualPerson getFirstName]);
    XCTAssertEqualObjects(expectedLastName, [actualPerson getLastName]);
    XCTAssertEqualObjects(expectedEmail, [actualPerson getEmailAddress]);
}


- (void)testParsePerson_MissingKeysWillReturnNullPerson {


    NSDictionary *missingFirstNameDictionary = [NSDictionary dictionaryWithObjects:
            [NSArray arrayWithObjects:@"", @"", nil] forKeys:[NSArray arrayWithObjects:@"lastName", @"email", nil]];
    NSDictionary *missingLastNameDictionary = [NSDictionary dictionaryWithObjects:
            [NSArray arrayWithObjects:@"", @"", nil] forKeys:[NSArray arrayWithObjects:@"firstName", @"email", nil]];
    NSDictionary *missingEmailDictionary = [NSDictionary dictionaryWithObjects:
            [NSArray arrayWithObjects:@"", @"", nil] forKeys:[NSArray arrayWithObjects:@"firstName", @"lastName", nil]];

    [self checkNullPersonWhenMissingKeys:missingFirstNameDictionary];
    [self checkNullPersonWhenMissingKeys:missingLastNameDictionary];
    [self checkNullPersonWhenMissingKeys:missingEmailDictionary];

}

- (void)checkNullPersonWhenMissingKeys:(NSDictionary *)missingFirstNameDictionary {
    NSData *dataMissingFirstName = [NSJSONSerialization dataWithJSONObject:missingFirstNameDictionary options:0 error:nil];
    PersonParser *parser =[PersonParser singleton];
    NSObject <PersonProtocol> *parsedPerson = [parser parsePerson:dataMissingFirstName];
    XCTAssertEqual([NullPerson singleton], parsedPerson);
}
@end
