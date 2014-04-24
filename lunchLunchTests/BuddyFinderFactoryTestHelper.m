//
// Created by Cyrus on 4/21/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <objc/runtime.h>
#import "BuddyFinderFactoryTestHelper.h"
#import "BuddyFinderFactory.h"



NSObject<PersonReceiverProtocol> *personReceiverUsedToBuildBuddyFinder;

NSObject <BuddyFinderProtocol> *finderToReturn;

@implementation BuddyFinderFactoryTestHelper {

}
+ (void)swizzleBuildBuddyFinder {
    SEL mockSelector = @selector(mockBuildBuddyFinder:);
    SEL originalSelector = @selector(buildBuddyFinder:);

    Class originalClass = [BuddyFinderFactory class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockSelector];

    [SwizzleHelper swizzleMethodFunctionality:originalMethod withMockMethod:mockMethod];
}

+ (void)deswizzleBuildBuddyFinder {
    SEL mockSelector = @selector(mockBuildBuddyFinder:);
    SEL originalSelector = @selector(buildBuddyFinder:);

    Class originalClass = [BuddyFinderFactory class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockSelector];

    [SwizzleHelper deswizzleMethodFunctionality:originalMethod awayFromMockMethod:mockMethod];
    personReceiverUsedToBuildBuddyFinder= nil;
    finderToReturn =  nil;
}


- (NSObject <BuddyFinderProtocol> *)mockBuildBuddyFinder:(NSObject <PersonReceiverProtocol> *)personReciever {
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





