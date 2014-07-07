//
// Created by Cyrus on 7/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonCreatorProtocol.h"


@interface MockPersonCreator : NSObject<PersonCreatorProtocol>
- (NSString *)getFirstNameForCreate;

- (NSString *)getLastNameForCreate;

- (NSString *)getEmailForCreate;
@end