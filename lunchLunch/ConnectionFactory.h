//
// Created by Cyrus on 4/16/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionFactoryProtocol.h"

@interface ConnectionFactory : NSObject <ConnectionFactoryProtocol>
+ (ConnectionFactory *)singleton;
@end