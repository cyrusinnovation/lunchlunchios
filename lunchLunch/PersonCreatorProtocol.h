//
// Created by Cyrus on 7/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PersonCreatorProtocol <NSObject>
-(void) createPersonWithFirstName:(NSString* ) firstName lastName:(NSString*)lastName andEmail: (NSString*) email;
@end