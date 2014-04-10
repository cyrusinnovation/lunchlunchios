//
// Created by Cyrus on 4/4/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonProtocol.h"

@interface PersonProviderTestHelper : NSObject
+ (void)swizzleGetPerson;

+ (void)deswizzleGetPersonAndClearFields;

+ (NSString *)getEmailUsedToFindPerson;

+ (void)setPersonToReturn:(NSObject <PersonProtocol> *)person;
@end