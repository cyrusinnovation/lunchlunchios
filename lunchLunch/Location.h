//
// Created by Cyrus on 5/15/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationProtocol.h"


@interface Location : NSObject<LocationProtocol>{

}
- (id)initWithId:(NSString *)locationIdIn name:(NSString *)nameIn address:(NSString *)addressIn andZipCode:(NSString *)zipCodeIn;
@end