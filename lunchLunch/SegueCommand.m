//
// Created by Cyrus on 4/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "SegueCommand.h"
#import "MockViewController.h"


@implementation SegueCommand {


}
@synthesize viewController;
@synthesize segueIdentifier;

- (void)execute {
    [self.viewController performSegueWithIdentifier:segueIdentifier sender:self.viewController];
}

- (id)initForViewController:(UIViewController *)controller segueIdentifier:(NSString *)identifier {
    self = [super init];
    if (self) {
        viewController = controller;
        segueIdentifier = identifier;
    }
    return self;
}

- (UIViewController *)getViewController {
    return viewController;
}

- (NSString *)getSegueIdentifier {
    return segueIdentifier;
}

@end