//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockLunchUpdateHandler.h"


@implementation MockLunchUpdateHandler {

    bool handleLunchUpdateFailedCalled;
    bool handleLunchUpdateCalled;
}
- (void)handleLunchUpdate {
    handleLunchUpdateCalled = true;
}

- (void)handleLunchUpdateFailed {
    handleLunchUpdateFailedCalled = true;
}
-(BOOL) wasHandleLunchUpdateCalled{
    return handleLunchUpdateCalled;
}
-(BOOL) wasHandleLunchUpdateFailedCalled{
    return handleLunchUpdateFailedCalled;
}

@end