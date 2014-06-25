//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <objc/runtime.h>
#import "LunchUpdaterFactoryTestHelper.h"
#import "LunchUpdateHandler.h"
#import "LunchUpdaterProtocol.h"
#import "LunchUpdaterFactory.h"
#import "SwizzleHelper.h"


NSObject <LunchUpdaterProtocol> *lunchUpdaterToReturn;

NSObject <LunchUpdateHandler> *handlerUsedToBuild;

@implementation LunchUpdaterFactoryTestHelper {

}
+ (void)swizzleBuildLunchUpdater {
    SEL mockGetLunchesSelector = @selector(mockBuildLunchUpdater:);
    SEL originalSelector = @selector(buildLunchUpdater:);

    Class originalClass = [LunchUpdaterFactory class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockGetLunchesSelector];

    [SwizzleHelper swizzleMethodFunctionality:originalMethod withMockMethod:mockMethod];

}

+ (void)deswizzleBuildLunchUpdater {
    SEL mockGetLunchesSelector = @selector(mockBuildLunchUpdater:);
    SEL originalSelector = @selector(buildLunchUpdater:);

    Class originalClass = [LunchUpdaterFactory class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockGetLunchesSelector];

    [SwizzleHelper deswizzleMethodFunctionality:originalMethod awayFromMockMethod:mockMethod];

}

+ (NSObject <LunchUpdateHandler> *)getLunchUpdateHandlerUsedToBuild {
    return handlerUsedToBuild;
}

+ (void)setLunchUpdaterToReturn:(NSObject <LunchUpdaterProtocol> *)updaterToReturn {
    lunchUpdaterToReturn = updaterToReturn;
}

- (NSObject <LunchUpdaterProtocol> *)mockBuildLunchUpdater:(NSObject <LunchUpdateHandler> *)handler {
    handlerUsedToBuild = handler;
    return lunchUpdaterToReturn;
}

@end