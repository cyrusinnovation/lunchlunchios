//
// Created by Cyrus on 4/10/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailsTableViewController.h"
#import "DisplayHandlerFactory.h"
#import "NullLocation.h"
#import "SegueCommand.h"
#import "CommandDispatcher.h"
#import "LocationMapViewController.h"


@implementation DetailViewController {

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailsTable"]) {
        DetailsTableViewController *controller = (DetailsTableViewController *) segue.destinationViewController;
        controller.personLoggedIn = self.personLoggedIn;
        controller.lunch = self.lunch;
    }
    if([segue.identifier isEqualToString:@"showMapView"]){
        LocationMapViewController *controller = (LocationMapViewController *) segue.destinationViewController;
        controller.location = [self.lunch getLocation];
    }
}
- (IBAction)findLunchLocationPushed:(id)sender {
    if ([[self.lunch getLocation] isEqual:[NullLocation singleton]]) {
        NSObject <DisplayHandlerProtocol> *displayHandler = [DisplayHandlerFactory buildDisplayHandler];
        [displayHandler showErrorWithMessage:@"This Lunch does not have a Location associate with it."];
    }
    else {
        [[CommandDispatcher singleton] executeCommand:[[SegueCommand alloc] initForViewController:self segueIdentifier:@"showMapView"]];
    }
}

@end