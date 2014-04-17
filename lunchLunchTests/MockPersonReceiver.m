//
// Created by Cyrus on 4/17/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockPersonReceiver.h"
#import "PersonProtocol.h"


@implementation MockPersonReceiver {

    NSObject <PersonProtocol> *personPassedIn;
}
- (void)handlePersonFound:(NSObject <PersonProtocol> *)person {
    personPassedIn = person;
}
-(NSObject<PersonProtocol> *) getPersonPassedIn{
    return personPassedIn;
}

@end