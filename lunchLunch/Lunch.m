//
// Created by Cyrus on 4/4/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "Lunch.h"
#import "LocationProtocol.h"

@implementation Lunch {

}
- (id)initWithId:(NSString *)idIn person1:(NSObject <PersonProtocol> *)person1In person2:(NSObject <PersonProtocol> *)person2In dateTime:(NSDate *)timeIn andLocation:(NSObject <LocationProtocol> *)locationIn {
    self = [super init];
    if (self) {
        lunchId = idIn;
        person1 = person1In;
        person2 = person2In;
        dateTime = timeIn;
        location = locationIn;
    }

    return self;
}


- (NSString *)getId {
    return lunchId;
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

- (NSObject <LocationProtocol> *)getLocation {
    return location;
}


@end