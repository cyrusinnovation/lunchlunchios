//
// Created by Cyrus on 6/26/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockLocationWriter.h"


@implementation MockLocationWriter {

    NSString *nameForCreate;
    NSString *addressForCreate;
    NSString *zipCodeForCreate;
}
- (void)createLocationWithName:(NSString *)name address:(NSString *)address andZipCode:(NSString *)zipCode {
    nameForCreate = name;
    addressForCreate = address;
    zipCodeForCreate = zipCode;
}
-(NSString *)getNameForCreate{
    return nameForCreate;
}
-(NSString *)getAddressForCreate{
    return addressForCreate;
}
-(NSString *)getZipCodeForCreate{
    return zipCodeForCreate;
}

@end