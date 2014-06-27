//
// Created by Cyrus on 4/10/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "DetailsTableViewController.h"
#import "NullLocation.h"


@interface DetailsTableViewController ()
- (NSObject <PersonProtocol> *)findLunchBuddy:(NSObject <LunchProtocol> *)lunch;
@end

@implementation DetailsTableViewController {


}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"M/d/yyyy"];

    NSDateFormatter * timeFormatter = [[NSDateFormatter alloc] init] ;
    [timeFormatter setDateFormat:@"h:mm a"];
    NSObject <PersonProtocol> *lunchBuddy = [self findLunchBuddy:self.lunch];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", [lunchBuddy getFirstName], [lunchBuddy getLastName]];
    self.dateLabel.text = [dateFormatter stringFromDate:[self.lunch getDateAndTime]];
    self.timeLabel.text = [timeFormatter stringFromDate:[self.lunch getDateAndTime]];

    NSObject <LocationProtocol> *location = [self.lunch getLocation];
    self.locationNameLabel.text = [location getName];
    self.locationZipCodeLabel.text = [location getZipCode];
    self.locationAddressLabel.text = [location getAddress];
}


- (NSObject <PersonProtocol> *)findLunchBuddy:(NSObject <LunchProtocol> *)lunch {
    if ([[lunch getPerson1] isEqual:self.personLoggedIn]) {
        return [lunch getPerson2];
    }
    return [lunch getPerson1];

}



@end

