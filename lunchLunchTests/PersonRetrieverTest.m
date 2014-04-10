//
// Created by Cyrus on 4/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "PersonRetriever.h"
#import "Person.h"

@interface PersonRetrieverTest : XCTestCase
@end

@implementation PersonRetrieverTest {

}
-(void) testImplementsProtocol{
    XCTAssertTrue([PersonRetriever conformsToProtocol:@protocol(PersonRetrieverProtocol)]);
}

-(void) testGetAllPeopleReturnsStubPeopleForNow{
    PersonRetriever * retriever = [[PersonRetriever alloc] init];
    NSArray *allPeople = [retriever getAllPeople];
    XCTAssertEqual(5, [allPeople count]);
    [self checkPerson:allPeople atIndex:0 withFirstName:@"Jeff" lastName: @"Jia" email:@"jjia@cyrusinnovation.com"];
    [self checkPerson:allPeople atIndex:1 withFirstName:@"David" lastName: @"Blinn" email:@"dblinn@cyrusinnovation.com"];
    [self checkPerson:allPeople atIndex:2 withFirstName:@"Colin" lastName: @"McEnearney" email:@"cmcenearney@cyrusinnovation.com"];
    [self checkPerson:allPeople atIndex:3 withFirstName:@"Britt" lastName: @"Lewis" email:@"blewis@cyrusinnovation.com"];
    [self checkPerson:allPeople atIndex:4 withFirstName:@"Lisa" lastName: @"van Gelder" email:@"lvangelder@cyrusinnovation.com"];

}
-(void) testGetAllPeopleGivesSameStubListOfPeopleEachTime{
    PersonRetriever * retriever = [[PersonRetriever alloc] init];
     XCTAssertEqual([retriever getAllPeople], [retriever getAllPeople]);


}


- (void)checkPerson:(NSArray *)allPeople atIndex:(int)i withFirstName: (NSString*)expectedFirstName lastName: (NSString*)expectedLastName email: (NSString*)expectedEmail{
    Person * person = [allPeople objectAtIndex:i];
    XCTAssertTrue([person isKindOfClass:[Person class]]);
    XCTAssertEqualObjects(expectedFirstName, [person getFirstName]);
    XCTAssertEqualObjects(expectedLastName, [person getLastName]);
    XCTAssertEqualObjects(expectedEmail, [person getEmailAddress]);

}


@end