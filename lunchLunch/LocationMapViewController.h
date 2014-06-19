//
// Created by Cyrus on 5/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationProtocol.h"
#import "DirectionHandlerProtocol.h"


@interface LocationMapViewController : UIViewController<DirectionHandlerProtocol>
@property(nonatomic, strong) NSObject <LocationProtocol>  *location;
@end