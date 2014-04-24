//
// Created by Cyrus on 4/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LunchCreationHandler <NSObject>
-(void) handleLunchCreated;
-(void) handleLunchCreationFailed;
@end