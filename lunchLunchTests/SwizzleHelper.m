//
// Created by Cyrus on 4/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "SwizzleHelper.h"
#import <objc/runtime.h>

@implementation SwizzleHelper {


}

+ (Method)findClassMethod:(Class)theClass withSelector:(SEL)selector {
    return class_getClassMethod(theClass, selector);
}

+ (Method)findInstanceMethod:(Class)theClass withSelector:(SEL)selector {
    return class_getInstanceMethod(theClass, selector);
}


+ (void)swizzleMethodFunctionality:(Method)originalMethod withMockMethod:(Method)mockMethod {
    method_exchangeImplementations(originalMethod, mockMethod);

}

+ (void)deswizzleMethodFunctionality:(Method)originalMethod awayFromMockMethod:(Method)mockMethod {
    method_exchangeImplementations( mockMethod,originalMethod);
}


@end