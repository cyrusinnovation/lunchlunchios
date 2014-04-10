//
// Created by Cyrus on 4/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "PersonRetriever.h"
#import "Person.h"


@implementation PersonRetriever {

    NSArray *allPeople;
}
- (id)init {
    self = [super init];
    if (self) {

        Person *person1 = [[Person alloc] initWithFirstName:@"Jeff" lastName: @"Jia" email:@"jjia@cyrusinnovation.com"];
        Person *person2 = [[Person alloc] initWithFirstName:@"David" lastName: @"Blinn" email:@"dblinn@cyrusinnovation.com"];
        Person *person3 = [[Person alloc] initWithFirstName:@"Colin" lastName: @"McEnearney" email:@"cmcenearney@cyrusinnovation.com"];
        Person *person4 = [[Person alloc] initWithFirstName:@"Britt" lastName: @"Lewis" email:@"blewis@cyrusinnovation.com"];
        Person *person5 = [[Person alloc] initWithFirstName:@"Lisa" lastName: @"van Gelder" email:@"lvangelder@cyrusinnovation.com"];

        allPeople = [NSArray arrayWithObjects:person1, person2, person3, person4, person5, nil];

    }

    return self;
}

- (NSArray *)getAllPeople {

    return allPeople;
}

@end