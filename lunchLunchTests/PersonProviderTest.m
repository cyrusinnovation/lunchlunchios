//
// Created by Cyrus on 4/2/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PersonProvider.h"
#import "Person.h"
#import "SegueCommand.h"
#import "MockPersonRetriever.h"
#import "NullPerson.h"

@interface PersonProviderTest : XCTestCase

@end

@implementation PersonProviderTest {

}

- (void)testFindPersonByEmail {
    MockPersonRetriever *retriever = [[MockPersonRetriever alloc] init];
    Person *person1 = [[Person alloc] initWithFirstName:@"" lastName:@"" email:@"email@mcgee.com"];
    Person *person2 = [[Person alloc] initWithFirstName:@"" lastName:@"" email:@"joeyjoejoe@shabadou.com"];
    Person *person3 = [[Person alloc] initWithFirstName:@"" lastName:@"" email:@"johnsmith@yahoo.com"];
    Person *person4 = [[Person alloc] initWithFirstName:@"" lastName:@"" email:@"dude.mcduderson@elduderino.com"];

    NSArray * allPeople = [NSArray arrayWithObjects:person1,person2,person3,person4,nil];
    [retriever setPeopleToReturn:allPeople];
    PersonProvider *provider = [[PersonProvider alloc] initWithRetriever:retriever];
    XCTAssertEqual(person2, [provider findPersonByEmail:@"joeyjoejoe@shabadou.com"]);
    XCTAssertEqual(person3, [provider findPersonByEmail:@"johnsmith@yahoo.com"]);
    XCTAssertEqual([NullPerson singleton], [provider findPersonByEmail:@"thisisanemailthatwedonothave@nope.com"]);



}
@end