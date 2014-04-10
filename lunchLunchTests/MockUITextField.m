//
// Created by Cyrus on 4/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockUITextField.h"

@interface MockUITextField ()

@property (nonatomic,  readwrite) BOOL resignFirstResponderWasCalled;
@end
@implementation MockUITextField {

}

-(BOOL)resignFirstResponder {
  self.resignFirstResponderWasCalled = true;
  return true;
}

@end