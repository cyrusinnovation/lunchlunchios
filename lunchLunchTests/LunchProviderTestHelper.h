//
// Created by Cyrus on 4/9/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonProtocol.h"

@interface LunchProviderTestHelper : NSObject
+ (void)swizzleGetLunchesForPerson;

+ (void)deswizzleGetLunchesForPersonAndClearFields;

+ (NSObject <PersonProtocol> *)getPersonUsedToFindLunches;

+ (void)setLunchesToReturn:(NSArray *)allLunches;
@end