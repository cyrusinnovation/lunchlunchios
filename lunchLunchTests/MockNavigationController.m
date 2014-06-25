//
// Created by Cyrus on 4/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockNavigationController.h"


@implementation MockNavigationController {

    BOOL popViewControllerAnimatedCalled;
    BOOL shouldAnimatePop;
    bool popToRootWasCalled;
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    popViewControllerAnimatedCalled = true;
    shouldAnimatePop = animated;
    return [super popViewControllerAnimated:animated];
}

- (BOOL)wasPopViewControllerAnimatedCalled {
    return popViewControllerAnimatedCalled;
}

- (BOOL)shouldAnimatePop {
    return shouldAnimatePop;
}

-(bool) wasPopToRootCalled{
    return popToRootWasCalled;
}
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    popToRootWasCalled = true;
    return [super popToRootViewControllerAnimated:animated];
}

@end