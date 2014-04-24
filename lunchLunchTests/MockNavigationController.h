//
// Created by Cyrus on 4/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MockNavigationController : UINavigationController
- (BOOL)wasPopViewControllerAnimatedCalled;

- (BOOL)shouldAnimatePop;
@end