//
// Created by Cyrus on 4/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonProtocol.h"


@interface NullPerson : NSObject<PersonProtocol>
+(NullPerson*) singleton;
@end