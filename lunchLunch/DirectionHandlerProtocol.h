//
// Created by Cyrus on 6/19/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GMSPath;

@protocol DirectionHandlerProtocol <NSObject>
-(void) handleDirectionsReceived: (GMSPath*) path;
-(void) handleDirectionFailed;
@end