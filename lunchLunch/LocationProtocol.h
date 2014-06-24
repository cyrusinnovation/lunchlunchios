//
// Created by Cyrus on 5/15/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LocationProtocol <NSObject>
- (NSString *) getId;
- (NSString *)getName;

- (NSString *)getAddress;

- (NSString *)getZipCode;

@end