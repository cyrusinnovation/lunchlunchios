//
// Created by Cyrus on 7/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <objc/runtime.h>
#import "PersonCreatorFactoryTestHelper.h"
#import "PersonCreatorProtocol.h"
#import "PersonReceiverProtocol.h"
#import "PersonCreatorFactory.h"
#import "SwizzleHelper.h"


NSObject <PersonReceiverProtocol> *receiverUsedForBuild;

NSObject <PersonCreatorProtocol> *creatorToReturn;

@implementation PersonCreatorFactoryTestHelper {

}
+ (void)swizzleBuildPersonCreator {
    SEL mockSelector = @selector(mockbuildPersonCreator:);
    SEL originalSelector = @selector(buildPersonCreator:);

    Class originalClass = [PersonCreatorFactory class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockSelector];

    [SwizzleHelper swizzleMethodFunctionality:originalMethod withMockMethod:mockMethod];
}

+ (void)deswizzleBuildPersonCreator {

    SEL mockSelector = @selector(mockbuildPersonCreator:);
    SEL originalSelector = @selector(buildPersonCreator:);

    Class originalClass = [PersonCreatorFactory class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockSelector];

    [SwizzleHelper deswizzleMethodFunctionality:originalMethod awayFromMockMethod:mockMethod];
}

+ (NSObject <PersonReceiverProtocol> *)getPersonReceiverUsedToBuildCreator {
    return receiverUsedForBuild;
}

+ (void)setCreatorToReturn:(NSObject <PersonCreatorProtocol> *)creator {
    creatorToReturn=  creator;

}
-(NSObject<PersonCreatorProtocol> *) mockbuildPersonCreator:(NSObject<PersonReceiverProtocol> *) receiver{
    receiverUsedForBuild = receiver;
    return creatorToReturn;

}

@end