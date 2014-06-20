//
// Created by Cyrus on 6/20/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "DirectionsProviderFactory.h"
#import "DirectionsProviderProtocol.h"
#import "DirectionsProvider.h"
#import "ConnectionFactory.h"


@implementation DirectionsProviderFactory {

}
+ (NSObject <DirectionsProviderProtocol> *)buildDirectionProvider {
    return [[DirectionsProvider alloc] initWithConnectionFactory:[ConnectionFactory singleton]];
}

@end