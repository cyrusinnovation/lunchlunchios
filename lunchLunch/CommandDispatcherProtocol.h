//
//  CommandDispatcherProtocol.h
//  lunchLunch
//
//  Created by Cyrus on 4/2/14.
//  Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"

@protocol CommandDispatcherProtocol <NSObject>
    -(void) executeCommand: (NSObject<Command> *) command;
@end