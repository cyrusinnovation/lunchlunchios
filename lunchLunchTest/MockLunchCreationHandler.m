//
// Created by Cyrus on 4/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockLunchCreationHandler.h"


@implementation MockLunchCreationHandler {

    bool handleLunchCreatedCalled;
    bool handleLunchCreationFailedCalled;
}
- (void)handleLunchCreated {
    handleLunchCreatedCalled = true;
}

- (void)handleLunchCreationFailed {
    handleLunchCreationFailedCalled = true;
}

- (BOOL)wasHandleLunchCreateCalled {
    return handleLunchCreatedCalled;
}

- (BOOL)wasHandleLunchCreationFailedCalled {
    return handleLunchCreationFailedCalled;
}
@end