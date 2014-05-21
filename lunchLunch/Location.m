//
// Created by Cyrus on 5/15/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "Location.h"


@implementation Location {


}

- (id)initWithName:(NSString *)nameIn address:(NSString *)addressIn andZipCode:(NSString *)zipCodeIn {
    self = [super init];
    if (self) {
        name = nameIn;
        address = addressIn;
        zipCode = zipCodeIn;
    }
    return self;
}

- (NSString *)getName {
    return name;
}


- (NSString *)getAddress {
    return address;
}

- (NSString *)getZipCode {
    return zipCode;
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    }
    if ([[other class] isEqual:[self class]]) {
        return [name isEqualToString:[other getName]]
                && [address isEqualToString:[other getAddress]]
                && [zipCode isEqualToString:[other getZipCode]];
    }

    return NO;
}

- (NSUInteger)hash {
    return 17 * [name hash] * [address hash] * [zipCode hash];
}

@end
