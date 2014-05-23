//
// Created by Cyrus on 5/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <GoogleMaps/GoogleMaps.h>
#import "LocationMapViewController.h"

@interface LocationMapViewControllerTest : XCTestCase
@property(nonatomic, strong) LocationMapViewController * viewController;
@end

@implementation LocationMapViewControllerTest {

}

- (void)setUp {
    [super setUp];
    self.viewController = [[LocationMapViewController alloc] init];

}

- (void)tearDown {
    self.viewController = nil;
    [super tearDown];
}

-(void) testViewDidLoadWillSetTheViewToAGmsMapView_ComparesNameBecauseOfSomeWeirdMagicIDoNotUnderstandYetWhereItIsNotOfTheCorrectClassButItActuallyIs{
    [self.viewController viewDidLoad];
    XCTAssertEqualObjects(@"GMSMapView", NSStringFromClass ([self.viewController.view class]));

}
@end