//
// Created by Cyrus on 4/4/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//


#import "LunchRetriever.h"
#import "Person.h"
#import "Lunch.h"


@implementation LunchRetriever {
    NSArray *allLunches;
}

- (id)init {
    self = [super init];
    if (self) {

        NSDateFormatter *dateMaker = [[NSDateFormatter alloc] init];
        [dateMaker setDateFormat:@"MM/dd/yyyy hh:mm"];

        Person *jjia = [[Person alloc] initWithFirstName:@"Jeff" lastName:@"Jia" email:@"jjia@cyrusinnovation.com"];
        Person *dblinn = [[Person alloc] initWithFirstName:@"David" lastName:@"Blinn" email:@"dblinn@cyrusinnovation.com"];
        Person *cmcenearney = [[Person alloc] initWithFirstName:@"Colin" lastName:@"McEnearney" email:@"cmcenearney@cyrusinnovation.com"];
        Person *blewis = [[Person alloc] initWithFirstName:@"Britt" lastName:@"Lewis" email:@"blewis@cyrusinnovation.com"];
        Person *lvangelder = [[Person alloc] initWithFirstName:@"Lisa" lastName:@"van Gelder" email:@"lvangelder@cyrusinnovation.com"];


        Lunch *lunch1 = [[Lunch alloc] initWithPerson1:jjia person2:dblinn dateTime:[dateMaker dateFromString:@"12/22/2016 12:00"]];
        Lunch *lunch2 = [[Lunch alloc] initWithPerson1:jjia person2:cmcenearney dateTime:[dateMaker dateFromString:@"1/31/2016 12:30"]];
        Lunch *lunch3 = [[Lunch alloc] initWithPerson1:jjia person2:blewis dateTime:[dateMaker dateFromString:@"4/30/2016 1:00"]];
        Lunch *lunch4 = [[Lunch alloc] initWithPerson1:jjia person2:lvangelder dateTime:[dateMaker dateFromString:@"5/21/2016 1:30"]];
        Lunch *lunch5 = [[Lunch alloc] initWithPerson1:dblinn person2:cmcenearney dateTime:[dateMaker dateFromString:@"2/27/2016 12:00"]];
        Lunch *lunch6 = [[Lunch alloc] initWithPerson1:dblinn person2:blewis dateTime:[dateMaker dateFromString:@"11/13/2016 12:30"]];
        Lunch *lunch7 = [[Lunch alloc] initWithPerson1:dblinn person2:lvangelder dateTime:[dateMaker dateFromString:@"9/12/2016 1:00"]];
        Lunch *lunch8 = [[Lunch alloc] initWithPerson1:cmcenearney person2:blewis dateTime:[dateMaker dateFromString:@"8/1/2016 1:30"]];
        Lunch *lunch9 = [[Lunch alloc] initWithPerson1:cmcenearney person2:lvangelder dateTime:[dateMaker dateFromString:@"6/12/2016 12:00"]];
        Lunch *lunch10 = [[Lunch alloc] initWithPerson1:blewis person2:lvangelder dateTime:[dateMaker dateFromString:@"4/22/2016 12:30"]];

        allLunches = @[lunch1, lunch2, lunch3, lunch4, lunch5, lunch6, lunch7, lunch8, lunch9, lunch10];
    }

    return self;
}

- (NSArray *)getAllLunches {
    return allLunches;
}

@end