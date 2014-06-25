//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LunchUpdaterFactory.h"
#import "LunchUpdaterProtocol.h"
#import "LunchUpdater.h"
#import "ConnectionFactory.h"
#import "LocationParser.h"


@implementation LunchUpdaterFactory {

}
+ (NSObject <LunchUpdaterProtocol> *)buildLunchUpdater:(NSObject <LunchUpdateHandler> *)handler {
    return [[LunchUpdater alloc] initWithConnectionFactory:[ConnectionFactory singleton] andUpdateHandler:handler];
}
@end