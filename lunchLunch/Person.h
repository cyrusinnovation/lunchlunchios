//
// Created by Cyrus on 4/2/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonProtocol.h"


@interface Person : NSObject <PersonProtocol>
{
    NSString* firstName;
    NSString* lastName;
    NSString* email;
}
- (id)initWithFirstName:(NSString *)string lastName:(NSString *)name email:(NSString *)email;
- (BOOL)isEqual:(id)other;
- (NSUInteger)hash ;
@end