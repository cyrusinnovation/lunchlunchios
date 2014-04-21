//
// Created by Cyrus on 4/21/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PersonReceiverProtocol;
@protocol BuddyFinderProtocol;


@interface BuddyFinderFactoryTestHelper : NSObject
+ (void)swizzleBuildBuddyFinder;

+ (void)deswizzleBuildBuddyFinder;

+ (NSObject <PersonReceiverProtocol> *)getPersonReceiverUsedToBuildBuddyFinder;

+ (void)setBuddyFinderToReturn:(NSObject<BuddyFinderProtocol> *)finderToReturn;
@end