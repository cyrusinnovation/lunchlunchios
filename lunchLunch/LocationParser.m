//
// Created by Cyrus on 5/20/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LocationParser.h"
#import "LocationProtocol.h"
#import "Location.h"
#import "NullLocation.h"


@implementation LocationParser {

}
+ (LocationParser *)singleton {
    static LocationParser *SINGLETON;
    if (!SINGLETON) {
        SINGLETON = [[LocationParser alloc] init];

    }
    return SINGLETON;
}
- (NSObject <LocationProtocol> *)parseLocationUsingDictionary:(NSDictionary *)dictionary {
    if([self dictionaryHasAllKeys:dictionary]) {
        return [[Location alloc] initWithName:[dictionary objectForKey:@"name"]
                                      address:[dictionary objectForKey:@"address"]
                                   andZipCode:[dictionary objectForKey:@"zipCode"]];
    }
    else{
        return [NullLocation singleton];
    }
}

- (BOOL)dictionaryHasAllKeys:(NSDictionary *)dictionary {

    return [self hasKey:dictionary key:@"name"] && [self hasKey:dictionary key:@"address"] && [self hasKey:dictionary key:@"zipCode"];
}

- (BOOL)hasKey:(NSDictionary *)dictionary key:(NSString *)key {

    return [[dictionary allKeys] containsObject:key];
}

@end