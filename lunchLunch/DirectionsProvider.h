//
// Created by Cyrus on 5/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DirectionsProviderProtocol.h"
#import "ConnectionFactoryProtocol.h"
#import "DirectionHandlerProtocol.h"


@interface DirectionsProvider : NSObject<NSURLConnectionDataDelegate, DirectionsProviderProtocol>
@property(nonatomic, strong) NSMutableData *connectionData;

- (id)initWithConnectionFactory:(NSObject <ConnectionFactoryProtocol> *)factory andDirectionHandler:(NSObject <DirectionHandlerProtocol> *)handler;
-(NSObject<ConnectionFactoryProtocol> *) getConnectionFactory;
-(NSObject<DirectionHandlerProtocol> *) getDirectionHandler;
@end