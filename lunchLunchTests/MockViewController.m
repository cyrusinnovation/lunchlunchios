//
// Created by Cyrus on 4/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockViewController.h"


@implementation MockViewController {

}

-(void) performSegueWithIdentifier:(NSString*)identifier sender :(id)sender{
   self.segueToPerform = identifier;
   self.senderForPerformSegue = sender;
}

@end


