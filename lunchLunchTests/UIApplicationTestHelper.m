//
// Created by Cyrus on 6/20/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <objc/runtime.h>
#import "UIApplicationTestHelper.h"
#import "SwizzleHelper.h"


NSURL *urlOpened;

@implementation UIApplicationTestHelper {

}
+ (void)swizzleOpenURL {
    SEL mockSelector = @selector(mockOpenURL:);
    SEL originalSelector = @selector(openURL:);

    Class originalClass = [UIApplication class];

    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findInstanceMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockSelector];

    [SwizzleHelper swizzleMethodFunctionality:originalMethod withMockMethod:mockMethod];
}

+ (void)deswizzleOpenURL {
    SEL mockTransitionViewSelector = @selector(mockOpenURL:);
    SEL originalSelector = @selector(openURL:);

    Class originalClass = [UIApplication class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findInstanceMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockTransitionViewSelector];

    [SwizzleHelper deswizzleMethodFunctionality:originalMethod awayFromMockMethod:mockMethod];
    urlOpened = nil;
}

+ (NSURL *)getURLOpened {
    return urlOpened;
}


-(void) mockOpenURL: (NSURL *) urlToOpen{
    urlOpened = urlToOpen;
}
@end