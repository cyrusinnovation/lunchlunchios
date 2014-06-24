//
// Created by Cyrus on 5/15/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "Location.h"


@implementation Location {
    NSString *name;
    NSString *address;
    NSString *zipCode;
    NSString *locationId;

}

- (id)initWithId:(NSString *)locationIdIn name:(NSString *)nameIn address:(NSString *)addressIn andZipCode:(NSString *)zipCodeIn {
    self = [super init];
    if (self) {
        name = nameIn;
        address = addressIn;
        zipCode = zipCodeIn;
        locationId = locationIdIn ;
    }
    return self;
}

- (NSString *)getId {
    return locationId;
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
        return [locationId isEqualToString:[other getId]]&& [name isEqualToString:[other getName]]
                && [address isEqualToString:[other getAddress]]
                && [zipCode isEqualToString:[other getZipCode]];

    }

    return NO;
}

- (NSUInteger)hash {
    return 17 * [name hash] * [address hash] * [zipCode hash] * [locationId hash];
}

@end
