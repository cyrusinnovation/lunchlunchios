//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LocationReceiverProtocol;
@protocol LocationProviderProtocol;


@interface LocationProviderFactoryTestHelper : NSObject
+ (void)swizzleBuildLocationProvider;

+ (void)deswizzleBuildLocationProvider;

+ (NSObject <LocationReceiverProtocol> *)getLocationReceiverUsedToBuildProvider;

+ (void)setLocationProviderToReturn:(NSObject <LocationProviderProtocol> *)providerToReturn;
@end