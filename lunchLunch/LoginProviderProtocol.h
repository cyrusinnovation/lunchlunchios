//
// Created by Cyrus on 4/17/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginProviderProtocol <NSObject>
- (void)findPersonByEmail:(NSString *)email;
@end