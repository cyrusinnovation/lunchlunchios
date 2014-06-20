//
// Created by Cyrus on 6/20/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DirectionsProviderProtocol;


@interface DirectionProviderFactoryTestHelper : NSObject
+ (void)swizzleBuildDirectionProvider;

+ (void)deswizzleBuildDirectionProvider;


+ (void)setDirectionProviderToReturn:(NSObject <DirectionsProviderProtocol> *)providerToReturn;
@end