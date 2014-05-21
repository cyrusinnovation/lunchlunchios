//
// Created by Cyrus on 5/15/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationProtocol.h"


@interface Location : NSObject<LocationProtocol>{
    NSString *name;
    NSString *address;
    NSString *zipCode;
}
- (id)initWithName:(NSString *)nameIn address:(NSString *)addressIn andZipCode:(NSString *)zipCodeIn ;
@end