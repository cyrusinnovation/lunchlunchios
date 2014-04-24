//
// Created by Cyrus on 4/21/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonReceiverProtocol.h"
#import "BuddyFinderProtocol.h"



@interface BuddyFinderFactory : NSObject
+(NSObject<BuddyFinderProtocol> *) buildBuddyFinder :(NSObject<PersonReceiverProtocol> *) personReceiver;
@end