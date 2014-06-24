//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LocationProtocol;


@interface LocationDetailTableViewController : UITableViewController
@property(nonatomic, strong) NSObject <LocationProtocol>  *location;
@property (strong, nonatomic) IBOutlet UILabel *locationNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationZipCodeLabel;

@end