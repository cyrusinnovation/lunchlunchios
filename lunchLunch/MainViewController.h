//
//  MainViewController.h
//  lunchLunch
//
//  Created by Cyrus on 4/2/14.
//  Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonProtocol.h"

@class Person;

@interface MainViewController : UITableViewController
@property(nonatomic, strong) NSObject <PersonProtocol>  *personLoggedIn;
@end
