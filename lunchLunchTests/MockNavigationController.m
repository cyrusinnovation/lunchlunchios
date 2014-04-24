//
// Created by Cyrus on 4/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockNavigationController.h"


@implementation MockNavigationController {

    bool popViewControllerAnimatedCalled;
    BOOL shouldAnimatePop;
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

@end