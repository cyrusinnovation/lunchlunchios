//
// Created by Cyrus on 6/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LocationSelectionController.h"
#import "LocationProviderFactory.h"


@implementation LocationSelectionController {

    NSArray *locationsFound;
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


@end