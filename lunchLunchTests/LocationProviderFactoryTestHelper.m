//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <objc/runtime.h>
#import "LocationProviderFactoryTestHelper.h"
#import "LocationReceiverProtocol.h"
#import "LocationProviderProtocol.h"
#import "LocationProviderFactory.h"
#import "SwizzleHelper.h"


NSObject <LocationProviderProtocol> *locationProviderToReturn;

NSObject <LocationReceiverProtocol> *locationReceiverUsed;

@implementation LocationProviderFactoryTestHelper {

}
+ (void)swizzleBuildLocationProvider {
    SEL mockSelector = @selector(mockBuildLocationProvider:);
    SEL originalSelector = @selector(buildLocationProvider:);

    Class originalClass = [LocationProviderFactory class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockSelector];

    [SwizzleHelper swizzleMethodFunctionality:originalMethod withMockMethod:mockMethod];

}

+ (void)deswizzleBuildLocationProvider {
    SEL mockSelector = @selector(mockBuildLocationProvider:);
    SEL originalSelector = @selector(buildLocationProvider:);

    Class originalClass = [LocationProviderFactory class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockSelector];

    [SwizzleHelper deswizzleMethodFunctionality:originalMethod awayFromMockMethod:mockMethod];

}

+ (void)setLocationProviderToReturn:(NSObject <LocationProviderProtocol> *)providerToReturn {
    locationProviderToReturn= providerToReturn;

}

+ (NSObject <LocationReceiverProtocol> *)getLocationReceiverUsedToBuildProvider {
    return locationReceiverUsed;
}

-(NSObject<LocationProviderProtocol>*)mockBuildLocationProvider:(NSObject<LocationReceiverProtocol> *) locationReceiver{
    locationReceiverUsed = locationReceiver;
    return locationProviderToReturn;
}
@end