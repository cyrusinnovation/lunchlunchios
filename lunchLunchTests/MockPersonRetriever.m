//
// Created by Cyrus on 4/4/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockPersonRetriever.h"


@implementation MockPersonRetriever {

}


-(void) setPeopleToReturn :(NSArray *) people{
    peopleToReturn = people;
}
- (NSArray *)getAllPeople {
    return peopleToReturn;
}

@end