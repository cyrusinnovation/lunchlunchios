//
// Created by Cyrus on 7/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonReceiverProtocol.h"
#import "PersonCreatorProtocol.h"


@interface PersonCreatorFactoryTestHelper : NSObject
+ (void)swizzleBuildPersonCreator;

+ (void)deswizzleBuildPersonCreator;

+ (NSObject <PersonReceiverProtocol> *)getPersonReceiverUsedToBuildCreator;

+ (void)setCreatorToReturn:(NSObject<PersonCreatorProtocol> *)creatorToReturn;
@end