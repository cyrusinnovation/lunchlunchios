//
// Created by Cyrus on 4/9/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LunchProviderTestHelper.h"
#import "LunchProvider.h"
#import "SwizzleHelper.h"

NSObject <PersonProtocol> *personUsedToFindLunches;
NSArray *lunchesToReturn;
@implementation LunchProviderTestHelper {

}
+ (void)swizzleGetLunchesForPerson {
    SEL mockGetLunchesSelector = @selector(mockGetAllLunches:);
    SEL originalSelector = @selector(findLunchesFor:);

    Class originalClass = [LunchProvider class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findInstanceMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockGetLunchesSelector];

    [SwizzleHelper swizzleMethodFunctionality:originalMethod withMockMethod:mockMethod];

}

+ (void)deswizzleGetLunchesForPersonAndClearFields {
    SEL mockGetLunchesSelector = @selector(mockGetAllLunches:);
    SEL originalSelector = @selector(findLunchesFor:);

    Class originalClass = [LunchProvider class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findInstanceMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockGetLunchesSelector];

    [SwizzleHelper swizzleMethodFunctionality:mockMethod withMockMethod:originalMethod];

    personUsedToFindLunches = nil;
    lunchesToReturn = nil;
}

+ (NSObject<PersonProtocol> *)getPersonUsedToFindLunches {
    return personUsedToFindLunches;
}

+ (void)setLunchesToReturn:(NSArray *)allLunches {
    lunchesToReturn = allLunches;
}

- (NSArray *)mockGetAllLunches:(NSObject <PersonProtocol> *)person {
    personUsedToFindLunches = person;
    return lunchesToReturn;
}

@end