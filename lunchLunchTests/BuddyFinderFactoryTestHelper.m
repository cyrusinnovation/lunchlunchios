//
// Created by Cyrus on 4/21/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <objc/runtime.h>
#import "BuddyFinderFactoryTestHelper.h"
#import "PersonReceiverProtocol.h"
#import "BuddyFinderProtocol.h"
#import "BuddyFinderFactory.h"
#import "SwizzleHelper.h"


NSObject<PersonReceiverProtocol> *personReceiverUsedToBuildBuddyFinder;

NSObject <BuddyFinderProtocol> *finderToReturn;

@implementation BuddyFinderFactoryTestHelper {

}
+ (void)swizzleBuildBuddyFinder {
    SEL mockGetLunchesSelector = @selector(mockBuildBuddyFinder:);
    SEL originalSelector = @selector(buildBuddyFinder:);

    Class originalClass = [BuddyFinderFactory class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockGetLunchesSelector];

    [SwizzleHelper swizzleMethodFunctionality:originalMethod withMockMethod:mockMethod];
}

+ (void)deswizzleBuildBuddyFinder {
    SEL mockGetLunchesSelector = @selector(mockBuildLoginProvider:);
    SEL originalSelector = @selector(buildLoginProvider:);

    Class originalClass = [BuddyFinderFactory class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockGetLunchesSelector];

    [SwizzleHelper deswizzleMethodFunctionality:originalMethod awayFromMockMethod:mockMethod];
    personReceiverUsedToBuildBuddyFinder= nil;
    finderToReturn =  nil;
}


- (NSObject <BuddyFinderProtocol> *)mockBuildBuddyFinder:(NSObject <BuddyFinderProtocol> *)personReciever {
    personReceiverUsedToBuildBuddyFinder = personReciever;
    return finderToReturn;
}

+ (NSObject <PersonReceiverProtocol> *)getPersonReceiverUsedToBuildBuddyFinder {
    return personReceiverUsedToBuildBuddyFinder;
}

+ (void)setBuddyFinderToReturn:(NSObject <BuddyFinderProtocol> *)finder {
    finderToReturn = finder;
}

@end





