//
// Created by Cyrus on 4/18/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonProtocol.h"

@protocol LunchProviderProtocol <NSObject>
- (void)findLunchesFor:(NSObject <PersonProtocol> *)person;
@end