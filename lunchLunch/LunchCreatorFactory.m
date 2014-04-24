//
// Created by Cyrus on 4/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LunchCreatorFactory.h"
#import "LunchCreatorProtocol.h"
#import "LunchReceiverProtocol.h"
#import "LunchCreator.h"
#import "ConnectionFactory.h"
#import "LunchParser.h"
#import "LunchCreationHandler.h"


@implementation LunchCreatorFactory {

}
+ (NSObject <LunchCreatorProtocol> *)buildLunchCreator:(NSObject <LunchCreationHandler> *)lunchCreationHandler {
    return [[LunchCreator alloc] initWithConnectionFactory:[ConnectionFactory singleton] lunchParser:[LunchParser singleton] andLunchCreationHandler:lunchCreationHandler];
}

@end