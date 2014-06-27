//
// Created by Cyrus on 6/25/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationCreationHandler.h"
#import "LunchUpdateHandler.h"
#import "LunchProtocol.h"
@interface CreateLocationViewController : UIViewController <LocationCreationHandler, LunchUpdateHandler>
- (IBAction)createLocationPressed:(id)sender;
@property(nonatomic, strong) NSObject <LunchProtocol>  *lunch;
@end