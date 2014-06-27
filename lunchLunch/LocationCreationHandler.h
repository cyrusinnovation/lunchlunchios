//
// Created by Cyrus on 6/26/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LocationProtocol;

@protocol LocationCreationHandler <NSObject>
-(void) locationSaved:(NSObject<LocationProtocol> *)location;
-(void)locationSaveError;
@end