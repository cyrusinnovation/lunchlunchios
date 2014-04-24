//
// Created by Cyrus on 4/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LunchCreatorFactoryTestHelper.h"
#import "LunchCreatorProtocol.h"
#import "SwizzleHelper.h"

#import "LunchCreatorFactory.h"
#import "LunchCreationHandler.h"


NSObject <LunchReceiverProtocol> *lunchReceiverUsedToBuild;

NSObject <LunchCreatorProtocol> *lunchCreatorToReturn;

@implementation LunchCreatorFactoryTestHelper {

}
+ (void)swizzleBuildLunchCreator {
    SEL mockGetLunchesSelector = @selector(mockBuildLunchCreator:);
    SEL originalSelector = @selector(buildLunchCreator:);

    Class originalClass = [LunchCreatorFactory class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockGetLunchesSelector];

    [SwizzleHelper swizzleMethodFunctionality:originalMethod withMockMethod:mockMethod];
}

+ (void)deswizzleBuildLunchCreator {
    SEL mockGetLunchesSelector = @selector(mockBuildLunchCreator:);
    SEL originalSelector = @selector(buildLunchCreator:);

    Class originalClass = [LunchCreatorFactory class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockGetLunchesSelector];

    [SwizzleHelper deswizzleMethodFunctionality:originalMethod awayFromMockMethod:mockMethod];
    lunchReceiverUsedToBuild = nil;
    lunchCreatorToReturn =  nil;
}

- (NSObject <LunchCreatorProtocol> *)mockBuildLunchCreator:(NSObject <LunchReceiverProtocol> *)lunchReceiver {
    lunchReceiverUsedToBuild = lunchReceiver;
    return lunchCreatorToReturn;
}


+ (NSObject <LunchReceiverProtocol> *)getLunchCreationHandlerUsedToBuildLunchCreator {
    return lunchReceiverUsedToBuild;
}

+ (void)setLunchCreatorToReturn:(NSObject <LunchCreatorProtocol> *)creatorToReturn {
    lunchCreatorToReturn= creatorToReturn;
}

@end