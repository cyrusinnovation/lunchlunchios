//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LocationDetailViewController.h"
#import "LocationProtocol.h"
#import "LocationDetailTableViewController.h"
#import "LunchUpdaterFactory.h"
#import "DisplayHandlerFactoryTestHelper.h"
#import "DisplayHandlerFactory.h"


@implementation LocationDetailViewController {

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"locationDetailTable"]) {
        LocationDetailTableViewController *controller = (LocationDetailTableViewController *) segue.destinationViewController;
        controller.location = self.location;
    }
}

- (IBAction)updateLunchButtonPressed:(id)sender {
    NSObject <LunchUpdaterProtocol> *updater = [LunchUpdaterFactory buildLunchUpdater:self];
    [updater updateLunch:self.lunch withLocation:self.location];
}

- (void)handleLunchUpdate {
    [self.navigationController popToRootViewControllerAnimated:true];
}

- (void)handleLunchUpdateFailed {
    NSObject <DisplayHandlerProtocol> *displayHandler = [DisplayHandlerFactory buildDisplayHandler];
    [displayHandler showCommunicationError];
}

@end