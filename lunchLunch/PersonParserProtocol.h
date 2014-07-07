//
// Created by Cyrus on 4/16/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonProtocol.h"



@protocol PersonParserProtocol <NSObject>
    -(NSObject<PersonProtocol> *)parsePersonUsingJsonData:(NSData * ) personJsonData;
    -(NSObject<PersonProtocol> *)parsePersonUsingDictionary:(NSDictionary *)personJsonDictionary;
    -(NSData *)buildPersonJSONData: (NSObject<PersonProtocol>* )person;
    -(NSData *)buildPersonJSONWithFirstName:(NSString *)firstName lastName:(NSString *)lastName emailAddress:(NSString *) email;
@end