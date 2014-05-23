//
// Created by Cyrus on 5/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>
#import "LocationMapViewController.h"
#import "LocationProtocol.h"


@implementation LocationMapViewController {

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[GMSMapView alloc] initWithFrame:CGRectZero];

}

@end