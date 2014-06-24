//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LocationDetailViewController.h"
#import "LocationProtocol.h"
#import "LocationDetailTableViewController.h"


@implementation LocationDetailViewController {

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"locationDetailTable"]) {
        LocationDetailTableViewController *controller = (LocationDetailTableViewController *) segue.destinationViewController;
        controller.location = self.location;
    }
}

@end