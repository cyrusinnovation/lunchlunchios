//
// Created by Cyrus on 6/20/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <objc/runtime.h>
#import "UIApplicationTestHelper.h"
#import "SwizzleHelper.h"


NSURL *urlOpened;

bool canOpenURL = true;

NSURL *urlChecked;

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
    SEL mockSelector = @selector(mockOpenURL:);
    SEL originalSelector = @selector(openURL:);

    Class originalClass = [UIApplication class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findInstanceMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockSelector];

    [SwizzleHelper deswizzleMethodFunctionality:originalMethod awayFromMockMethod:mockMethod];
    urlOpened = nil;
}

+ (void)swizzleCanOpenURL {
    SEL mockSelector = @selector(mockOpenURL:);
    SEL originalSelector = @selector(openURL:);

    Class originalClass = [UIApplication class];

    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findInstanceMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockSelector];

    [SwizzleHelper swizzleMethodFunctionality:originalMethod withMockMethod:mockMethod];
}

+ (void)deswizzleCanOpenURL {
    SEL mockSelector = @selector(mockCanOpenURL:);
    SEL originalSelector = @selector(canOpenURL:);

    Class originalClass = [UIApplication class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findInstanceMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockSelector];

    [SwizzleHelper deswizzleMethodFunctionality:originalMethod awayFromMockMethod:mockMethod];
}


+ (NSURL *)getURLOpened {
    return urlOpened;
}

+ (void)setCanOpenURL:(bool)canOpen {
    canOpenURL = canOpen;
}

+ (NSURL *)getUrlChecked {
    return urlChecked;
}

- (void)mockOpenURL:(NSURL *)urlToOpen {
    urlOpened = urlToOpen;
}

- (bool)mockCanOpenURL:(NSURL *)urlToCheck {
    urlChecked = urlToCheck;
    return canOpenURL;
}
@end
