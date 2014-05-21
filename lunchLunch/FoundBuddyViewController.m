//
//  FindBuddyViewController.m
//  lunchLunch
//
//  Created by Cyrus on 4/21/14.
//  Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "PersonReceiverProtocol.h"
#import "FoundBuddyViewController.h"
#import "BuddyDetailViewController.h"
#import "Lunch.h"
#import "LunchCreatorFactory.h"
#import "AlertBuilder.h"
#import "DisplayHandlerFactory.h"
#import "NullLocation.h"

@interface FoundBuddyViewController ()

@end

@implementation FoundBuddyViewController {
    BuddyDetailViewController *buddyDetailViewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"buddyDetails"]) {
        BuddyDetailViewController *controller = (BuddyDetailViewController *) segue.destinationViewController;
        buddyDetailViewController = controller;
        controller.buddy = self.buddy;
    }
}

- (IBAction)createLunch:(id)sender {
    if (buddyDetailViewController.date != nil) {
        Lunch *lunch = [[Lunch alloc] initWithPerson1:self.personLoggedIn person2:self.buddy dateTime:buddyDetailViewController.date andLocation:[NullLocation singleton] ];
        NSObject <LunchCreatorProtocol> *lunchCreator = [LunchCreatorFactory buildLunchCreator:self];
        [lunchCreator createLunch:lunch];
    }
    else {
        [[DisplayHandlerFactory buildDisplayHandler] showErrorWithMessage:@"Please enter a date to schedule your lunch"];
    }
}

- (void)handleLunchCreated {
    [[self navigationController] popViewControllerAnimated:true];

}

- (void)handleLunchCreationFailed {
    [[DisplayHandlerFactory buildDisplayHandler] showCommunicationError];
}


@end
