//
// Created by Cyrus on 4/2/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PersonProtocol <NSObject>
- (NSString *)getId;

- (NSString *)getFirstName;

- (NSString *)getLastName;

- (NSString *)getEmailAddress;

@end