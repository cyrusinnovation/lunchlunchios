//
// Created by Cyrus on 6/26/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LocationWriterProtocol.h"
#import "LocationCreationHandler.h"


@interface LocationWriterFactory : NSObject
+ (NSObject <LocationWriterProtocol> *)buildLocationWriter:(NSObject <LocationCreationHandler> *)handler;
@end