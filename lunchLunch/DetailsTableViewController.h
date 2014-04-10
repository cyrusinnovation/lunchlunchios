//
// Created by Cyrus on 4/10/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LunchProtocol.h"
#import "PersonProtocol.h"


@interface DetailsTableViewController : UITableViewController
@property(nonatomic, strong) NSObject <LunchProtocol>  *lunch;
@property(nonatomic, strong) NSObject <PersonProtocol>  *personLoggedIn;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@end