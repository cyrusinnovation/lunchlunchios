//
// Created by Cyrus on 4/10/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "LunchProtocol.h"



@interface DetailViewController : UIViewController<CLLocationManagerDelegate>
@property(nonatomic, strong) NSObject <LunchProtocol>  *lunch;
@property(nonatomic, strong) NSObject <PersonProtocol>  *personLoggedIn;
@property (strong, nonatomic) IBOutlet UIButton *lunchLocationButton;

- (IBAction)findLunchLocationPushed:(id)sender;
@end