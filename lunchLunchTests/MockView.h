//
// Created by Cyrus on 4/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MockView : UIView
@property(nonatomic, readonly) BOOL endEditingWasCalled;
@property (nonatomic, readonly) BOOL forceEndEditing;
@end