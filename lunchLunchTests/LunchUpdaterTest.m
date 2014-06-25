//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//



#import <XCTest/XCTest.h>
#import "LunchUpdater.h"
#import "LunchUpdaterProtocol.h"
#import "MockLunchUpdateHandler.h"
#import "MockConnectionFactory.h"
#import "MockLocationParser.h"
#import "Lunch.h"
#import "Location.h"

@interface LunchUpdaterTest : XCTestCase
@end

@implementation LunchUpdaterTest {

}
- (void)testIsANSURLConnectionDataDelegate {
    XCTAssertTrue([LunchUpdater conformsToProtocol:@ protocol(NSURLConnectionDataDelegate)]);
    XCTAssertTrue([LunchUpdater conformsToProtocol:@ protocol(LunchUpdaterProtocol)]);
}


- (void)testCanGetArgumentsFromInit {
    MockLunchUpdateHandler *updateHandler = [[MockLunchUpdateHandler alloc] init];
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    LunchUpdater *updater =
            [[LunchUpdater alloc] initWithConnectionFactory:factory andUpdateHandler:updateHandler];
    XCTAssertEqual(updateHandler, [updater getUpdateHandler]);
    XCTAssertEqual(factory, [updater getConnectionFactory]);
}

- (void)testUpdateLunch {
    MockLunchUpdateHandler *updateHandler = [[MockLunchUpdateHandler alloc] init];
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];
    LunchUpdater *updater =
            [[LunchUpdater alloc] initWithConnectionFactory:factory andUpdateHandler:updateHandler];


    NSString *lunchId = @"4534534";
    NSObject <LunchProtocol> *lunchToUpdate = [[Lunch alloc] initWithId:lunchId person1:nil person2:nil dateTime:nil andLocation:nil];
    Location *locationForUpdate = [[Location alloc] initWithId:@"dfsf" name:@"dgsdg" address:@"sdfdsf" andZipCode:@"55235"];
    NSDictionary *locationDictionary = [self buildLocationDictionary:locationForUpdate];
    NSDictionary *lunchDictionary = [NSDictionary dictionaryWithObject:lunchId forKey:@"_id"];



    [updater updateLunch:lunchToUpdate withLocation:locationForUpdate];
    NSDictionary *dataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:lunchDictionary, @"lunch", locationDictionary, @"location", nil];
    NSData *expectedDataForPut = [NSJSONSerialization dataWithJSONObject:dataDictionary options:NSJSONWritingPrettyPrinted error:nil];
    XCTAssertEqualObjects(expectedDataForPut, [factory getDataPassedInToPut]);
    XCTAssertEqualObjects(@"http://localhost:3000/setlunchlocation", [factory getRequestURLPassedInForPut]);
    XCTAssertEqual(updater, [factory getDelegatePassedInForPut]);

}

- (NSDictionary *)buildLocationDictionary:(NSObject<LocationProtocol> *)location {
    return [NSDictionary dictionaryWithObjectsAndKeys:[location getName], @"name", [location getAddress], @"address", [location getZipCode], @"zipCode", [location getId],@"_id", nil];

}

- (void)testDidFailWithError {

    MockLunchUpdateHandler *updateHandler = [[MockLunchUpdateHandler alloc] init];
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];

    LunchUpdater *updater =
            [[LunchUpdater alloc] initWithConnectionFactory:factory andUpdateHandler:updateHandler];
    [updater connection:nil didFailWithError:nil];
    XCTAssertTrue([updateHandler wasHandleLunchUpdateFailedCalled]);
}


- (void)testDidFinishLoading {

    MockLunchUpdateHandler *updateHandler = [[MockLunchUpdateHandler alloc] init];
    MockConnectionFactory *factory = [[MockConnectionFactory alloc] init];

    LunchUpdater *updater =
            [[LunchUpdater alloc] initWithConnectionFactory:factory andUpdateHandler:updateHandler];
    [updater connectionDidFinishLoading:nil];
    XCTAssertTrue([updateHandler wasHandleLunchUpdateCalled]);
}


@end
