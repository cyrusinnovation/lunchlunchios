//
// Created by Cyrus on 4/18/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LunchReceiverProtocol.h"


@interface MockLunchReceiver : NSObject <LunchReceiverProtocol>
- (NSArray *)getLunchesReceived;
@end