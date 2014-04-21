//
//  MainViewController.h
//  lunchLunch
//
//  Created by Cyrus on 4/2/14.
//  Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonProtocol.h"
#import "LunchReceiverProtocol.h"
#import "PersonReceiverProtocol.h"


@interface MainViewController:  UIViewController <UITableViewDelegate, UITableViewDataSource, LunchReceiverProtocol, PersonReceiverProtocol>
@property (strong, nonatomic) IBOutlet UITableView *lunchTable;
- (IBAction)findBuddyClicked:(id)sender;

@property(nonatomic, strong) NSObject <PersonProtocol>  *personLoggedIn;
@property(nonatomic, strong) NSObject<PersonProtocol>* buddyFound;
@end
