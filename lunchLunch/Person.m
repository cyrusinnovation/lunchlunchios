//
// Created by Cyrus on 4/2/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "Person.h"


@implementation Person {

}

- (id)initWithFirstName:(NSString *)inFirstName lastName:(NSString *)inLastName email:(NSString *)inEmail {
    self = [super init];
    if (self = [super init]) {
        firstName = inFirstName;
        lastName = inLastName;
        email = inEmail;

    }
    return self;
}

- (NSString *)getFirstName {
    return firstName;
}


- (NSString *)getLastName {
    return lastName;
}

- (NSString *)getEmailAddress {
    return email;
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    }
    if ([[other class] isEqual:[self class]]) {
        return [firstName isEqualToString:[other getFirstName]]
                && [lastName isEqualToString:[other getLastName]]
                && [email isEqualToString:[other getEmailAddress]];
    }

    return NO;
}

- (NSUInteger)hash {
    return 7 * [firstName hash] * [lastName hash] * [email hash];
}

@end