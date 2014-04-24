//
// Created by Cyrus on 4/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DisplayHandlerProtocol.h"


@interface MockDisplayHandler : NSObject<DisplayHandlerProtocol>
- (bool)wasShowCommunicationErrorCalled;

- (NSString *)getErrorMessageShown;
@end