//
// Created by Cyrus on 4/18/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LunchReceiverProtocol.h"
#import "LunchProviderProtocol.h"


@interface LunchProviderFactoryTestHelper : NSObject
+ (void)swizzleBuildLunchProvider;

+ (void)deswizzleBuildLunchProvider;

+ (NSObject <LunchReceiverProtocol> *)getLunchReceiverUsedToBuildLunchProvider;

+ (void)setLunchProviderToReturn:(NSObject <LunchProviderProtocol> *)providerToReturn;


@end