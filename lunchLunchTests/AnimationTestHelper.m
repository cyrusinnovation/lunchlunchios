//
// Created by Cyrus on 4/22/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "AnimationTestHelper.h"


UIView *viewToTransition;

NSTimeInterval durationForTransition;

UIViewAnimationOptions optionsForTransition;

@implementation AnimationTestHelper {

}
+ (void)swizzleTransitionWithView {
    SEL mockTransitionViewSelector = @selector(mockTransitionWithView:duration:options:animations:completion:);
    SEL originalSelector = @selector(transitionWithView:duration:options:animations:completion:);

    Class originalClass = [UIView class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockTransitionViewSelector];

    [SwizzleHelper swizzleMethodFunctionality:originalMethod withMockMethod:mockMethod];
}

+ (void)deswizzleTransitionWithView {
    SEL mockTransitionViewSelector = @selector(mockTransitionWithView:duration:options:animations:completion:);
    SEL originalSelector = @selector(transitionWithView:duration:options:animations:completion:);

    Class originalClass = [UIView class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findClassMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockTransitionViewSelector];

    [SwizzleHelper deswizzleMethodFunctionality:originalMethod awayFromMockMethod:mockMethod];
    viewToTransition = nil;
    durationForTransition = 0;
    optionsForTransition = 0;
}

+(UIView *) getViewToTransition{
    return viewToTransition;
}

+(NSTimeInterval) getDurationForTransition{
    return durationForTransition;
}
+(UIViewAnimationOptions) getAnimationOptionForTransition{
    return optionsForTransition;
}
- (void)mockTransitionWithView:(UIView *)view duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^) (void))animations completion:(void (^)(BOOL finished))completion {
    viewToTransition = view;
    durationForTransition = duration;
    optionsForTransition = options;

}


@end

