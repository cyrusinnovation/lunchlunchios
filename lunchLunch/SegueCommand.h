//
// Created by Cyrus on 4/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"


@interface SegueCommand : NSObject<Command>
@property(nonatomic, strong) UIViewController *viewController;

@property(nonatomic, copy) NSString *segueIdentifier;

- (id)initForViewController:(UIViewController *)controller segueIdentifier:(NSString *)identifier;

- (UIViewController*)getViewController;
- (NSString*)getSegueIdentifier;
@end
UIViewController *viewController;
NSString *segueIdentifier;
