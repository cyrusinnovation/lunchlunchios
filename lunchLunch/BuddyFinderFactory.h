//
// Created by Cyrus on 4/21/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BuddyFinderProtocol;
@protocol PersonReceiverProtocol;


@interface BuddyFinderFactory : NSObject
+(NSObject<BuddyFinderProtocol> *) buildBuddyFinder :(NSObject<PersonReceiverProtocol> *) personReceiver;
@end