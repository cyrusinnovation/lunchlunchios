//
// Created by Cyrus on 4/2/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "CommandDispatcher.h"


@implementation CommandDispatcher {

}

- (void)executeCommand:(NSObject <Command> *)command {
    [command execute];
}

+ (CommandDispatcher *)singleton {
    static CommandDispatcher *SINGLETON;
    if(!SINGLETON){
        SINGLETON = [[CommandDispatcher alloc]init];

    }
    return SINGLETON;
}

@end