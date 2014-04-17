//
// Created by Cyrus on 4/17/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonReceiverProtocol.h"
#import "LoginProviderProtocol.h"


@interface LoginProviderFactoryTestHelper : NSObject

+ (void)swizzleBuildLoginProvider;

+ (void)deswizzleBuildLoginProvider;

+ (NSObject <PersonReceiverProtocol> *)getPersonReceiverUsedToBuildLoginProvider;

+ (void)setLoginProviderToReturn:(NSObject<LoginProviderProtocol> *)providerToReturn;
@end