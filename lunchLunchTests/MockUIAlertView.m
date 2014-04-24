//
// Created by Cyrus on 4/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockUIAlertView.h"


@implementation MockUIAlertView {

    bool showWasCalled;
}
- (void)show {
    showWasCalled = true;
}
-(BOOL)wasShowCalled{
    return showWasCalled;
}

@end