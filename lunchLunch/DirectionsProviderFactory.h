//
// Created by Cyrus on 6/20/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DirectionsProviderProtocol.h"



@interface DirectionsProviderFactory : NSObject
+(NSObject<DirectionsProviderProtocol> *) buildDirectionProvider;
@end