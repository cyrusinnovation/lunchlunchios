//
// Created by Cyrus on 4/4/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LunchProtocol.h"


@interface Lunch : NSObject <LunchProtocol> {
    NSObject <PersonProtocol> *person1;
    NSObject <PersonProtocol> *person2;
    NSDate *dateTime;
}
- (id)initWithPerson1:(NSObject <PersonProtocol> *)person1In person2:(NSObject <PersonProtocol> *)person2In dateTime:(NSDate *)timeIn;
@end