//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LunchProtocol.h"
#import "LocationProtocol.h"
#import "LunchUpdateHandler.h"


@interface LocationDetailViewController : UIViewController<LunchUpdateHandler>
@property(nonatomic, strong) NSObject <LunchProtocol>  *lunch;

- (IBAction)updateLunchButtonPressed:(id)sender;
@property(nonatomic, strong) NSObject <LocationProtocol>  *location;
@end