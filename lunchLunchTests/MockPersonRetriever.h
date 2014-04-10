//
// Created by Cyrus on 4/4/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonRetrieverProtocol.h"


@interface MockPersonRetriever : NSObject <PersonRetrieverProtocol> {
    NSArray *peopleToReturn;
}

- (void)setPeopleToReturn:(NSArray *)people;
@end