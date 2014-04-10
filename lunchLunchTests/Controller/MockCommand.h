//
// Created by Cyrus on 4/2/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"


@interface MockCommand : NSObject <Command>
@property(nonatomic) bool executeWasCalled;
@end