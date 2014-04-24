//
// Created by Cyrus on 4/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DisplayHandlerProtocol.h"
#import "AlertBuilderProtocol.h"


@interface DisplayHandler : NSObject<DisplayHandlerProtocol>
- (id)initWithAlertBuilder:(NSObject <AlertBuilderProtocol> *)builder;
-(NSObject<AlertBuilderProtocol> *) getAlertBuilder;
@end