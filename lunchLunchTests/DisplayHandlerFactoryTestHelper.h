//
// Created by Cyrus on 4/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DisplayHandlerProtocol;


@interface DisplayHandlerFactoryTestHelper : NSObject

+ (void)swizzleBuildDisplayHandler;

+ (void)deswizzleBuildDisplayHandler;

+ (bool)buildDisplayHandlerCalled;

+ (void)setDisplayHandlerToBuild:(NSObject<DisplayHandlerProtocol> *) displayHandler;

@end