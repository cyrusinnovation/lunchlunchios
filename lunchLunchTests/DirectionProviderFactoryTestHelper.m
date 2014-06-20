//
// Created by Cyrus on 6/20/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <objc/runtime.h>
#import "DirectionProviderFactoryTestHelper.h"
#import "DirectionsProviderProtocol.h"
#import "SwizzleHelper.h"
#import "DirectionsProvider.h"
#import "DirectionsProviderFactory.h"


NSObject <DirectionsProviderProtocol> *directionProviderToReturn;

@implementation DirectionProviderFactoryTestHelper {

}
+ (void)swizzleBuildDirectionProvider {
    SEL mockGetLunchesSelector = @selector(mockBuildDirectionProvider);
    SEL originalSelector = @selector(buildDirectionProvider);

    Class originalClass = [DirectionsProviderFactory class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockGetLunchesSelector];

    [SwizzleHelper swizzleMethodFunctionality:originalMethod withMockMethod:mockMethod];
}

+ (void)deswizzleBuildDirectionProvider {
    SEL mockGetLunchesSelector = @selector(mockBuildDirectionProvider);
    SEL originalSelector = @selector(buildDirectionProvider);

    Class originalClass = [DirectionsProviderFactory class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockGetLunchesSelector];

    [SwizzleHelper deswizzleMethodFunctionality:originalMethod awayFromMockMethod:mockMethod];

}

+ (void)setDirectionProviderToReturn:(NSObject <DirectionsProviderProtocol> *)providerToReturn {
    directionProviderToReturn = providerToReturn;

}
- (NSObject<DirectionsProviderProtocol> *) mockBuildDirectionProvider{
    return directionProviderToReturn;
}

@end