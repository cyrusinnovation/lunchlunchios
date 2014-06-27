//
// Created by Cyrus on 6/26/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LocationWriterProtocol <NSObject>
-(void) createLocationWithName: (NSString *) name address:(NSString *)addres andZipCode:(NSString *)zipCode;
@end