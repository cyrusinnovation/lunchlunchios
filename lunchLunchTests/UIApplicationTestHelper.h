//
// Created by Cyrus on 6/20/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIApplicationTestHelper : NSObject

+ (void)swizzleOpenURL;

+ (void)deswizzleOpenURL;

+ (void)swizzleCanOpenURL;
+ (void)deswizzleCanOpenURL;

+ (NSURL *)getURLOpened;

+ (void)setCanOpenURL:(bool)canOpen;

+ (NSURL *)getUrlChecked;
@end