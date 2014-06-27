//
// Created by Cyrus on 6/26/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LocationWriterFactory.h"
#import "LocationWriterProtocol.h"
#import "LocationCreationHandler.h"
#import "LocationWriter.h"
#import "ConnectionFactory.h"
#import "LocationParser.h"


@implementation LocationWriterFactory {

}
+ (NSObject <LocationWriterProtocol> *)buildLocationWriter:(NSObject <LocationCreationHandler> *)handler {
    return [[LocationWriter alloc] initWithConnectionFactory:[ConnectionFactory singleton] parser:[LocationParser singleton] andCreationHandler:handler];
}
@end