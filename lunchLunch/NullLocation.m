//
// Created by Cyrus on 5/15/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "NullLocation.h"


@implementation NullLocation {

}


+ (NullLocation *)singleton {
    static NullLocation *SINGLETON;
    if(!SINGLETON){
        SINGLETON = [[NullLocation alloc]init];

    }
    return SINGLETON;
}

- (NSString *)getId {
    return @"";
}

- (NSString *)getName {
    return @"";
}

- (NSString *)getAddress {
    return @"";
}

- (NSString *)getZipCode {
    return @"";
}


@end