//
// Created by Cyrus on 4/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "AlertBuilder.h"


@implementation AlertBuilder {

}
- (UIAlertView *)buildAlert:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle {
    return [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:buttonTitle otherButtonTitles:nil];
}

+ (AlertBuilder *)singleton {
    static AlertBuilder *SINGLETON;
    if (!SINGLETON) {
        SINGLETON = [[AlertBuilder alloc] init];

    }
    return SINGLETON;
}


@end