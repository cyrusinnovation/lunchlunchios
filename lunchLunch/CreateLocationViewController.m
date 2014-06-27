//
// Created by Cyrus on 6/25/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LunchUpdateHandler.h"
#import "CreateLocationViewController.h"
#import "LunchProtocol.h"
#import "CreateLocationSubController.h"
#import "LocationWriterFactory.h"
#import "LunchUpdaterFactory.h"


@implementation CreateLocationViewController {

    CreateLocationSubController *subController;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"createLocationSubController"]) {
        
        subController = (CreateLocationSubController *) segue.destinationViewController;

    }
}

- (IBAction)createLocationPressed:(id)sender {
    NSObject <LocationWriterProtocol> *locationWriter = [LocationWriterFactory buildLocationWriter:self];
    [locationWriter createLocationWithName:subController.nameTextField.text address:subController.addressTextField.text andZipCode:subController.zipCodeTextField.text];
}

- (void)locationSaved:(NSObject <LocationProtocol> *)location {
    NSObject <LunchUpdaterProtocol> *updater = [LunchUpdaterFactory buildLunchUpdater:self];
    [updater updateLunch:self.lunch withLocation:location];

}

- (void)locationSaveError {

}

- (void)handleLunchUpdate {

    [self.navigationController popToRootViewControllerAnimated:true];
}

- (void)handleLunchUpdateFailed {

}


@end