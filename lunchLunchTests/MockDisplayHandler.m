//
// Created by Cyrus on 4/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockDisplayHandler.h"


@implementation MockDisplayHandler {

    bool showCommunicationErrorCalled;
    NSString *errorMessageShown;
}
- (void)showCommunicationError {
    showCommunicationErrorCalled = true;

}

- (void)showErrorWithMessage:(NSString *)message {
       errorMessageShown = message;
}
-(bool) wasShowCommunicationErrorCalled{
    return showCommunicationErrorCalled;
}

-(NSString *) getErrorMessageShown{
    return errorMessageShown;
}

@end