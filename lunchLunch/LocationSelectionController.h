//
// Created by Cyrus on 6/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LunchProtocol.h"
#import "LocationReceiverProtocol.h"

@interface LocationSelectionController : UIViewController<LocationReceiverProtocol,UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *locationTable;
@property(nonatomic, strong) NSObject <LunchProtocol>  *lunch;

@end