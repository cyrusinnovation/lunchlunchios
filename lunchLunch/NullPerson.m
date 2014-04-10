//
// Created by Cyrus on 4/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "NullPerson.h"


@implementation NullPerson {

}

+ (NullPerson *)singleton {
    static NullPerson *SINGLETON;
    if(!SINGLETON){
        SINGLETON = [[NullPerson alloc]init];

    }
    return SINGLETON;
}



- (NSString *)getFirstName {
    return @"";
}

- (NSString *)getLastName {
    return @"";
}

- (NSString *)getEmailAddress {
    return @"";
}


@end