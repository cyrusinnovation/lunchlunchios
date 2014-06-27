//
// Created by Cyrus on 6/26/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <objc/runtime.h>
#import "LocationWriterFactoryTestHelper.h"
#import "LocationWriterProtocol.h"
#import "LocationCreationHandler.h"
#import "LocationWriterFactory.h"
#import "SwizzleHelper.h"


NSObject <LocationWriterProtocol> *writerToReturn;

NSObject <LocationCreationHandler> *handlerUsedToBuild;

@implementation LocationWriterFactoryTestHelper {

}
+ (void)swizzleBuildLocationWriter {
    SEL mockSelector = @selector(mockBuildLocationWriter:);
    SEL originalSelector = @selector(buildLocationWriter:);

    Class originalClass = [LocationWriterFactory class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockSelector];

    [SwizzleHelper swizzleMethodFunctionality:originalMethod withMockMethod:mockMethod];

}

+ (void)deswizzleBuildLocationWriter {
    SEL mockSelector = @selector(mockBuildLocationWriter:);
    SEL originalSelector = @selector(buildLocationWriter:);

    Class originalClass = [LocationWriterFactory class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockSelector];

    [SwizzleHelper deswizzleMethodFunctionality:originalMethod awayFromMockMethod:mockMethod];
}

+ (NSObject <LocationCreationHandler> *)getLocationCreationHandlerUsedToBuildWriter {
    return handlerUsedToBuild;
}

+ (void)setLocationWriterToReturn:(NSObject <LocationWriterProtocol> *)writer {
    writerToReturn = writer;
}

- (NSObject <LocationWriterProtocol> *)mockBuildLocationWriter:(NSObject<LocationCreationHandler> *) handler {
    handlerUsedToBuild = handler;
    return writerToReturn;
}
@end