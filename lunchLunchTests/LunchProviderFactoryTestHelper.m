//
// Created by Cyrus on 4/18/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LunchProviderFactoryTestHelper.h"
#import "LunchProviderFactory.h"
#import "SwizzleHelper.h"
#import "LunchReceiverProtocol.h"


NSObject<LunchReceiverProtocol> *lunchReceiverUsedToBuildLoginProvider;

NSObject<LunchProviderProtocol> *lunchProviderToReturn;

@implementation LunchProviderFactoryTestHelper {

}

+ (void)swizzleBuildLunchProvider {
    SEL mockGetLunchesSelector = @selector(mockBuildLunchProvider:);
    SEL originalSelector = @selector(buildLunchProvider:);

    Class originalClass = [LunchProviderFactory class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockGetLunchesSelector];

    [SwizzleHelper swizzleMethodFunctionality:originalMethod withMockMethod:mockMethod];

}

+ (void)deswizzleBuildLunchProvider {

    SEL mockGetLunchesSelector = @selector(mockBuildLunchProvider:);
    SEL originalSelector = @selector(buildLunchProvider:);

    Class originalClass = [LunchProviderFactory class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockGetLunchesSelector];

    [SwizzleHelper deswizzleMethodFunctionality:originalMethod awayFromMockMethod:mockMethod];
    lunchReceiverUsedToBuildLoginProvider= nil;
    lunchProviderToReturn =  nil;
}

- (NSObject <LunchProviderProtocol> *)mockBuildLunchProvider:(NSObject <LunchReceiverProtocol> *)lunchReceiver {
    lunchReceiverUsedToBuildLoginProvider = lunchReceiver;
    return lunchProviderToReturn;
}


+ (NSObject <LunchReceiverProtocol> *)getLunchReceiverUsedToBuildLunchProvider {
    return lunchReceiverUsedToBuildLoginProvider;
}

+ (void)setLunchProviderToReturn:(NSObject <LunchProviderProtocol> *)providerToReturn {
    lunchProviderToReturn = providerToReturn;
}
@end