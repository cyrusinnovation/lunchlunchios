//
// Created by Cyrus on 7/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockPersonCreator.h"


@implementation MockPersonCreator {

    NSString *emailForCreate;
    NSString *firstNameForCreate;
    NSString *lastNameForCreate;
}
- (void)createPersonWithFirstName:(NSString *)firstName lastName:(NSString *)lastName andEmail:(NSString *)email {
    emailForCreate = email;
    firstNameForCreate = firstName;
    lastNameForCreate = lastName;
}


-(NSString *)getFirstNameForCreate{
    return firstNameForCreate;
}
-(NSString *)getLastNameForCreate{
    return lastNameForCreate;
}
-(NSString *)getEmailForCreate{
    return emailForCreate;
}
@end