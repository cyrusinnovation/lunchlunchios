//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LunchUpdateHandler;
@protocol LunchUpdaterProtocol;


@interface LunchUpdaterFactoryTestHelper : NSObject
+ (void)swizzleBuildLunchUpdater;

+ (void)deswizzleBuildLunchUpdater;

+ (NSObject <LunchUpdateHandler> *)getLunchUpdateHandlerUsedToBuild;

+ (void)setLunchUpdaterToReturn:(NSObject <LunchUpdaterProtocol> *)updaterToReturn;
@end