//
// Created by Cyrus on 6/25/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LunchProtocol;


@interface CreateLocationViewController : UIViewController
@property(nonatomic, strong) NSObject <LunchProtocol>  *lunch;
@end