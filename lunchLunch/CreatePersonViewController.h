//
// Created by Cyrus on 7/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonReceiverProtocol.h"


@interface CreatePersonViewController : UIViewController<PersonReceiverProtocol>
- (IBAction)createButtonPressed:(id)sender;

- (IBAction)backButtonPressed:(id)sender;
@end