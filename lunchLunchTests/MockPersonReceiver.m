//
// Created by Cyrus on 4/17/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockPersonReceiver.h"
#import "PersonProtocol.h"


@implementation MockPersonReceiver {

    NSObject <PersonProtocol> *personPassedIn;
    bool handlePersonFoundErrorCalled;
}
- (void)handlePersonFound:(NSObject <PersonProtocol> *)person {
    personPassedIn = person;
}

- (void)handlePersonFoundError {
    handlePersonFoundErrorCalled = true;
}

- (BOOL)wasHandlePersonErrorCalled {
    return handlePersonFoundErrorCalled;
}

- (NSObject <PersonProtocol> *)getPersonPassedIn {
    return personPassedIn;
}

@end