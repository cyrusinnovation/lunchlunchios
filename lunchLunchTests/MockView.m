//
// Created by Cyrus on 4/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockView.h"


@interface MockView ()
    @property (nonatomic, readwrite) BOOL endEditingWasCalled;
    @property (nonatomic, readwrite) BOOL forceEndEditing;
@end
@implementation MockView {


}
- (BOOL)endEditing:(BOOL)force {
    self.forceEndEditing = force;
    self.endEditingWasCalled = true;
    return true;
}
@end