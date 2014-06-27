//
// Created by Cyrus on 6/26/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LocationWriterProtocol.h"

@protocol LocationCreationHandler;


@interface LocationWriterFactoryTestHelper : NSObject
+ (void)swizzleBuildLocationWriter;

+ (void)deswizzleBuildLocationWriter;

+ (NSObject <LocationCreationHandler> *)getLocationCreationHandlerUsedToBuildWriter;

+ (void)setLocationWriterToReturn:(NSObject <LocationWriterProtocol> *)writerToReturn;
@end