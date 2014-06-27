//
// Created by Cyrus on 6/26/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationWriterProtocol.h"


@interface MockLocationWriter : NSObject<LocationWriterProtocol>
- (NSString *)getNameForCreate;

- (NSString *)getAddressForCreate;

- (NSString *)getZipCodeForCreate;
@end