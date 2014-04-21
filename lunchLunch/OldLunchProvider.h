//
// Created by Cyrus on 4/9/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LunchRetrieverProtocol.h"
#import "LunchProtocol.h"


@interface OldLunchProvider : NSObject
- (id)initWithLunchRetriever:(NSObject <LunchRetrieverProtocol> *)retriever;

- (NSArray *)findLunchesFor:(NSObject <PersonProtocol> *)person;
@end