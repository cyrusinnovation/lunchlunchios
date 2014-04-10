//
// Created by Cyrus on 4/2/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonProtocol.h"
#import "PersonRetrieverProtocol.h"



@interface PersonProvider : NSObject {
    NSObject <PersonRetrieverProtocol> *personRetriever;
}

- (id)initWithRetriever:(NSObject <PersonRetrieverProtocol> *)retriever;

- (NSObject <PersonProtocol> *)findPersonByEmail:(NSString *)email;

@end