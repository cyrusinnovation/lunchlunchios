//
// Created by Cyrus on 6/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LocationSelectionController.h"
#import "LocationProviderFactory.h"
#import "CommandDispatcher.h"
#import "SegueCommand.h"
#import "LocationDetailViewController.h"


@implementation LocationSelectionController {

    NSArray *locationsFound;
    NSObject <LocationProtocol> *detailedLocation;
}
- (void)handleLocationsFound:(NSArray *)locations {
    locationsFound = locations;
    [self.locationTable reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSObject <LocationProviderProtocol> *locationProvider = [LocationProviderFactory buildLocationProvider:self];
    [locationProvider getAllLocations];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [locationsFound count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCell" forIndexPath:indexPath];
    NSObject <LocationProtocol> *location = [locationsFound objectAtIndex:indexPath.row];
    cell.textLabel.text = [location getName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    detailedLocation = [locationsFound objectAtIndex:indexPath.row];
    SegueCommand *segueCommand = [[SegueCommand alloc] initForViewController:self segueIdentifier:@"showLocationDetails"];
    [[CommandDispatcher singleton] executeCommand:segueCommand];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showLocationDetails"]) {
        LocationDetailViewController *controller = (LocationDetailViewController *) segue.destinationViewController;
        controller.lunch = self.lunch;
        controller.location = detailedLocation;
    }
}

@end