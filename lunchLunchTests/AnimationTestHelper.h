//
// Created by Cyrus on 4/22/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SwizzleHelper.h"


@interface AnimationTestHelper : NSObject

+ (void)swizzleTransitionWithView;

+ (void)deswizzleTransitionWithView;

+ (UIView *)getViewToTransition;

+ (NSTimeInterval)getDurationForTransition;

+ (UIViewAnimationOptions)getAnimationOptionForTransition;
@end