//
// Created by Cyrus on 4/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "DisplayHandlerFactory.h"
#import "DisplayHandler.h"
#import "AlertBuilder.h"


@implementation DisplayHandlerFactory {

}
+ (NSObject <DisplayHandlerProtocol> *)buildDisplayHandler {

    static DisplayHandler *handler;
    if (!handler) {
        handler = [[DisplayHandler alloc] initWithAlertBuilder:[AlertBuilder singleton]];

    }
    return handler;
}
@end