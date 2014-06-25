//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LunchUpdateHandler.h"
#import "LunchUpdaterProtocol.h"


@interface LunchUpdaterFactory : NSObject
+ (NSObject <LunchUpdaterProtocol> *)buildLunchUpdater:(NSObject <LunchUpdateHandler> *)handler;
@end