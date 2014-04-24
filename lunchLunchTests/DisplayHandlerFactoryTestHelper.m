//
// Created by Cyrus on 4/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <objc/runtime.h>
#import "DisplayHandlerFactoryTestHelper.h"
#import "DisplayHandlerProtocol.h"
#import "SwizzleHelper.h"
#import "DisplayHandlerFactory.h"

bool buildDisplayHandlerCalled;
NSObject <DisplayHandlerProtocol> *displayHandlerToBuild;

@interface DisplayHandlerFactoryTestHelper ()
+ (Method)getMockMethod;

+ (Method)getOriginalMethod;
@end

@implementation DisplayHandlerFactoryTestHelper {


}
+ (void)swizzleBuildDisplayHandler {

    Method originalMethod= [self getOriginalMethod];
    Method mockMethod= [self getMockMethod];

    [SwizzleHelper swizzleMethodFunctionality:originalMethod withMockMethod:mockMethod];

}


+ (void)deswizzleBuildDisplayHandler {
    Method originalMethod= [self getOriginalMethod];
    Method mockMethod= [self getMockMethod];

    [SwizzleHelper deswizzleMethodFunctionality:originalMethod awayFromMockMethod:mockMethod];
    buildDisplayHandlerCalled = false;
    displayHandlerToBuild= nil;

}

+ (bool)buildDisplayHandlerCalled {
    return buildDisplayHandlerCalled;
}

+ (void)setDisplayHandlerToBuild:(NSObject <DisplayHandlerProtocol> *)displayHandler {
    displayHandlerToBuild= displayHandler;
}

-(NSObject<DisplayHandlerProtocol>*) mockBuildDisplayHandler{
    buildDisplayHandlerCalled = true;
    return displayHandlerToBuild;
}

+ (Method)getMockMethod {
    SEL mockTransitionViewSelector = @selector(mockBuildDisplayHandler);
    Class mockMethodClass = [self class];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockTransitionViewSelector];
    return mockMethod;
}

+ (Method)getOriginalMethod {
    SEL originalSelector = @selector(buildDisplayHandler);
    Class originalClass = [DisplayHandlerFactory class];
    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    return originalMethod;
}

@end