//
// Created by Cyrus on 4/10/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "DetailsTableViewController.h"


@implementation DetailsTableViewController {


}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"M/d/yyyy"];

    NSDateFormatter * timeFormatter = [[NSDateFormatter alloc] init] ;
    [timeFormatter setDateFormat:@"h:mm a"];
    NSObject <PersonProtocol> *lunchBuddy = [self.lunch getPerson2];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", [lunchBuddy getFirstName], [lunchBuddy getLastName]];
    self.dateLabel.text = [dateFormatter stringFromDate:[self.lunch getDateAndTime]];
    self.timeLabel.text = [timeFormatter stringFromDate:[self.lunch getDateAndTime]];
}

@end

