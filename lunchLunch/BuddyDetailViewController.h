//
//  BuddyDetailViewController.h
//  lunchLunch
//
//  Created by Cyrus on 4/21/14.
//  Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonProtocol.h"

@interface BuddyDetailViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property(nonatomic, strong) NSObject <PersonProtocol>  *buddy;

@end
