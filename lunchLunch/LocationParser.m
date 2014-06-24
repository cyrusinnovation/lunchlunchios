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
    if ([self dictionaryHasAllKeys:dictionary]) {
        return [[Location alloc] initWithId:[dictionary objectForKey:@"_id"] name:[dictionary objectForKey:@"name"] address:[dictionary objectForKey:@"address"] andZipCode:[dictionary objectForKey:@"zipCode"]];
    }
    else {
        return [NullLocation singleton];
    }
}

- (NSArray *)parseLocationList:(NSData *)locationData {

    NSArray *locationDataArray = [NSJSONSerialization
            JSONObjectWithData:locationData
                       options:0
                         error:nil];

    NSMutableArray *locations = [[NSMutableArray alloc] init];
    for (NSDictionary *locationDictionary in locationDataArray) {
        if ([self dictionaryHasAllKeys:locationDictionary]) {
            [locations addObject:[self parseLocationUsingDictionary:locationDictionary]];
        }
    }
    return locations;
}


- (BOOL)dictionaryHasAllKeys:(NSDictionary *)dictionary {

    return [self hasKey:dictionary key:@"name"] && [self hasKey:dictionary key:@"address"] && [self hasKey:dictionary key:@"zipCode"] && [self hasKey:dictionary key:@"_id"];
}

- (BOOL)hasKey:(NSDictionary *)dictionary key:(NSString *)key {

    return [[dictionary allKeys] containsObject:key];
}

@end