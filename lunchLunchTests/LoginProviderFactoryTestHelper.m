//
// Created by Cyrus on 4/17/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LoginProviderFactoryTestHelper.h"
#import "SwizzleHelper.h"
#import "LoginProviderFactory.h"

NSObject <PersonReceiverProtocol> *personReceiverUsedToBuildLoginProvider;
NSObject <LoginProviderProtocol> *loginProviderToReturn;

@implementation LoginProviderFactoryTestHelper {

}
+ (void)swizzleBuildLoginProvider {
    SEL mockGetLunchesSelector = @selector(mockBuildLoginProvider:);
    SEL originalSelector = @selector(buildLoginProvider:);

    Class originalClass = [LoginProviderFactory class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockGetLunchesSelector];

    [SwizzleHelper swizzleMethodFunctionality:originalMethod withMockMethod:mockMethod];

}

+ (void)deswizzleBuildLoginProvider {

    SEL mockGetLunchesSelector = @selector(mockBuildLoginProvider:);
    SEL originalSelector = @selector(buildLoginProvider:);

    Class originalClass = [LoginProviderFactory class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockGetLunchesSelector];

    [SwizzleHelper deswizzleMethodFunctionality:originalMethod awayFromMockMethod:mockMethod];
    personReceiverUsedToBuildLoginProvider= nil;
    loginProviderToReturn =  nil;
}

- (NSObject <LoginProviderProtocol> *)mockBuildLoginProvider:(NSObject <PersonReceiverProtocol> *)personReciever {
    personReceiverUsedToBuildLoginProvider = personReciever;
    return loginProviderToReturn;
}


+ (NSObject <PersonReceiverProtocol> *)getPersonReceiverUsedToBuildLoginProvider {
    return personReceiverUsedToBuildLoginProvider;
}

+ (void)setLoginProviderToReturn:(NSObject <LoginProviderProtocol> *)providerToReturn {
    loginProviderToReturn = providerToReturn;
}

@end