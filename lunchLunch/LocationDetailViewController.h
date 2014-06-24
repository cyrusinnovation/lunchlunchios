//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LunchProtocol.h"
#import "LocationProtocol.h"


@interface LocationDetailViewController : UIViewController
@property(nonatomic, strong) NSObject <LunchProtocol>  *lunch;
@property(nonatomic, strong) NSObject <LocationProtocol>  *location;
@end