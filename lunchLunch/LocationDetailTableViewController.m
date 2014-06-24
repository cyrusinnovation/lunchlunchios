//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LocationDetailTableViewController.h"
#import "LocationProtocol.h"


@implementation LocationDetailTableViewController {

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationNameLabel.text = [self.location getName] ;
    self.locationAddressLabel.text = [self.location getAddress] ;
    self.locationZipCodeLabel.text = [self.location getZipCode] ;
}

@end