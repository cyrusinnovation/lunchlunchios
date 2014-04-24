//
// Created by Cyrus on 4/22/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LunchProtocol;

@protocol LunchCreatorProtocol <NSObject>
- (void)createLunch:(NSObject <LunchProtocol> *)lunch;
@end