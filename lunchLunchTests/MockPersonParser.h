//
// Created by Cyrus on 4/17/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonParserProtocol.h"


@interface MockPersonParser : NSObject<PersonParserProtocol>

- (NSString *)getFirstNameForBuild;

- (NSString *)getLastNameForBuild;

- (NSString *)getEmailForBuild;

- (void)setPersonJSONToReturn:(NSData *)string;

- (void)setPersonToReturn:(NSObject <PersonProtocol> *)person;

- (NSObject<PersonProtocol> *)getPersonToJSONify;

- (NSData *)getPersonDataPassedIn;
@end