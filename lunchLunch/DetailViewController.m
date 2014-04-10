//
// Created by Cyrus on 4/10/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailsTableViewController.h"


@implementation DetailViewController {

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailsTable"]) {
        DetailsTableViewController *controller = (DetailsTableViewController *) segue.destinationViewController;
        controller.personLoggedIn = self.personLoggedIn;
        controller.lunch = self.lunch;
    }
}

@end