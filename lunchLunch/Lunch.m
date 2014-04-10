//
// Created by Cyrus on 4/4/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "Lunch.h"

@implementation Lunch {

}
- (id)initWithPerson1:(NSObject <PersonProtocol> *)person1In person2:(NSObject <PersonProtocol> *)person2In dateTime:(NSDate *)timeIn {
    self = [super init];
    if(self){
        person1  =person1In;
        person2 = person2In;
        dateTime = timeIn;
    }

    return self;
}


- (NSObject <PersonProtocol> *)getPerson1 {
    return person1;
}


- (NSObject <PersonProtocol> *)getPerson2 {
    return person2;
}


- (NSDate *)getDateAndTime {
    return dateTime;
}

@end