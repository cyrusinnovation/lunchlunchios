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
#import "ShowMapCommand.h"
#import "DirectionsProviderFactory.h"


@implementation DetailViewController {

    CLLocationManager *locationManager;
}
- (void)viewDidLoad {
    locationManager = [[CLLocationManager alloc] init];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailsTable"]) {
        DetailsTableViewController *controller = (DetailsTableViewController *) segue.destinationViewController;
        controller.personLoggedIn = self.personLoggedIn;
        controller.lunch = self.lunch;
    }

}

- (IBAction)findLunchLocationPushed:(id)sender {
    if ([[self.lunch getLocation] isEqual:[NullLocation singleton]]) {
        NSObject <DisplayHandlerProtocol> *displayHandler = [DisplayHandlerFactory buildDisplayHandler];
        [displayHandler showErrorWithMessage:@"This Lunch does not have a Location associate with it."];
    }
    else {
        
        ShowMapCommand *command = [[ShowMapCommand alloc] initWithLocationManager:locationManager andDelegate:self];
        [[CommandDispatcher singleton] executeCommand:command];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSObject <DirectionsProviderProtocol> *directionProvider = [DirectionsProviderFactory buildDirectionProvider];
    [directionProvider findDirectionsTo:[self.lunch getLocation] fromOrigin:[locations lastObject]];
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSObject <DisplayHandlerProtocol> *displayHandler = [DisplayHandlerFactory buildDisplayHandler];
    [displayHandler showErrorWithMessage: @"There was an error determining your location, make sure location services are turned on"];
    [manager stopUpdatingLocation];
}




@end