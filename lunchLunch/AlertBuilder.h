//
// Created by Cyrus on 4/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlertBuilderProtocol.h"


@interface AlertBuilder : NSObject<AlertBuilderProtocol>
+(AlertBuilder *) singleton;
@end