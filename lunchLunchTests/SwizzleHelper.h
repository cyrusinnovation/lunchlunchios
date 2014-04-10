//
// Created by Cyrus on 4/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@interface SwizzleHelper : NSObject
+ (Method)findClassMethod:(Class)theClass withSelector:(SEL)selector;

+ (Method)findInstanceMethod:(Class)theClass withSelector:(SEL)selector;

+ (void)swizzleMethodFunctionality:(Method)originalMethod withMockMethod:(Method)mockMethod;

+ (void)deswizzleMethodFunctionality:(Method)originalMethod awayFromMockMethod:(Method)mockMethod;
@end