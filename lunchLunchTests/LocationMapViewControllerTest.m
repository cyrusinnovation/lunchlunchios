//
// Created by Cyrus on 5/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <GoogleMaps/GoogleMaps.h>
#import "LocationMapViewController.h"
#import "MockDirectionHandler.h"

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
- (void)testIsOfCorrectProtocol {
    XCTAssertTrue([LocationMapViewController conformsToProtocol:@ protocol(DirectionHandlerProtocol)]);
}
-(void) testViewDidLoadWillSetTheViewToAGmsMapView_ComparesNameBecauseOfSomeWeirdMagicIDoNotUnderstandYetWhereItIsNotOfTheCorrectClassButItActuallyIs{
    [self.viewController viewDidLoad];
    XCTAssertEqualObjects(@"GMSMapView", NSStringFromClass ([self.viewController.view class]));
    [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    GMSMapView * mapView =(GMSMapView *)self.viewController.view;
    XCTAssertTrue(mapView.isMyLocationEnabled);
}
-(void)testMapViewHasObserver{
    [self.viewController viewDidLoad];
    GMSMapView * mapView =(GMSMapView *)self.viewController.view;

    @try{
        [mapView removeObserver:self.viewController forKeyPath:@"myLocation"];
    }
    @catch(id exception) {
        XCTFail(@"The observer was never added");
    }
}
-(void) testObserveValueForKeyPathWillSetMapCameraToTheMapLocationOnTheFirstChange{
    [self.viewController viewDidLoad];
    GMSMapView * mapView =(GMSMapView *)self.viewController.view;
    CLLocation *location = [[CLLocation alloc] initWithLatitude:35 longitude:23];

    NSDictionary *change = [[NSDictionary alloc] initWithObjectsAndKeys: location, NSKeyValueChangeNewKey, nil];
    
    [self.viewController observeValueForKeyPath:@"myLocation" ofObject:mapView change:change context:NULL];

    GMSCameraPosition *cameraPosition = mapView.camera;
    XCTAssertEqual(location.coordinate.latitude, cameraPosition.target.latitude);
    XCTAssertEqual(location.coordinate.longitude, cameraPosition.target.longitude);
    XCTAssertEqual(14, cameraPosition.zoom);

    CLLocation *anotherLocation = [[CLLocation alloc] initWithLatitude:5555 longitude:1112];
    NSDictionary *secondChange = [[NSDictionary alloc] initWithObjectsAndKeys: anotherLocation, NSKeyValueChangeNewKey, nil];
    [self.viewController observeValueForKeyPath:@"myLocation" ofObject:mapView change:secondChange context:NULL];

    cameraPosition = mapView.camera;
    XCTAssertEqual(location.coordinate.latitude, cameraPosition.target.latitude);
    XCTAssertEqual(location.coordinate.longitude, cameraPosition.target.longitude);
    XCTAssertEqual(14, cameraPosition.zoom);
}


@end