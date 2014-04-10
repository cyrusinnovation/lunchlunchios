//
// Created by Cyrus on 4/4/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"



@interface CommandDispatcherTestHelper : NSObject
+(void) swizzleExecute ;
+(void)deswizzleExecuteAndClearLastCommandExecuted;
+ (NSObject<Command>*) getLastCommandExecuted;
@end

