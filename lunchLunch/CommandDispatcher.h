//
// Created by Cyrus on 4/2/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommandDispatcherProtocol.h"


@interface CommandDispatcher : NSObject<CommandDispatcherProtocol>
+ (CommandDispatcher *)singleton;
@end