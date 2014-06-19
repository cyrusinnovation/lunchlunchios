//
// Created by Cyrus on 5/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>
#import "LocationMapViewController.h"
#import "LocationProtocol.h"
#import "DirectionsProvider.h"
#import "ConnectionFactory.h"


@implementation LocationMapViewController {
    BOOL firstLocationUpdate;
    GMSMapView *mapView;
}
- (void)viewDidLoad {

   [super viewDidLoad];
    mapView = [[GMSMapView alloc] initWithFrame:CGRectZero];
    [mapView addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView.myLocationEnabled = YES;
    });

    self.view = mapView;

}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (!firstLocationUpdate && [keyPath isEqualToString:@"myLocation"]) {
        firstLocationUpdate = YES;
        CLLocation *origin = [change objectForKey:NSKeyValueChangeNewKey];
        mapView.camera = [GMSCameraPosition cameraWithTarget:origin.coordinate
                                                         zoom:14];
    }
}

- (void)handleDirectionsReceived:(GMSPath *)path {

}

- (void)handleDirectionFailed {

}


@end