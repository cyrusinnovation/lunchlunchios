//
// Created by Cyrus on 4/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LunchCreatorProtocol.h"
#import "LunchReceiverProtocol.h"

@protocol LunchCreationHandler;

@interface LunchCreatorFactoryTestHelper : NSObject

+ (void)swizzleBuildLunchCreator;

+ (void)deswizzleBuildLunchCreator;

+ (NSObject <LunchCreationHandler> *)getLunchCreationHandlerUsedToBuildLunchCreator;

+ (void)setLunchCreatorToReturn:(NSObject <LunchCreatorProtocol> *)creatorToReturn;

@end