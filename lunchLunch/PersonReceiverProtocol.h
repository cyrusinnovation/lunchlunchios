//
// Created by Cyrus on 4/16/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonProtocol.h"


@protocol PersonReceiverProtocol <NSObject>
- (void)handlePersonFound:(NSObject <PersonProtocol> *)person;
- (void)handlePersonFoundError;
@end