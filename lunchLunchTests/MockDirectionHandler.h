//
// Created by Cyrus on 6/19/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DirectionHandlerProtocol.h"


@interface MockDirectionHandler : NSObject<DirectionHandlerProtocol> {
    bool handleDirectionFailedCalled;
}
@property(nonatomic) bool handleDirectionFailedCalled;
@end