//
// Created by Cyrus on 4/17/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockLoginProvider.h"


@implementation MockLoginProvider {

    NSString *emailUsed;
}
- (void)findPersonByEmail:(NSString *)email {
    emailUsed = email;

}
-(NSString *)getEmailUsedToFindPerson{
    return emailUsed;
}

@end