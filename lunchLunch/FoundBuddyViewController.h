//
//  FindBuddyViewController.h
//  lunchLunch
//
//  Created by Cyrus on 4/21/14.
//  Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonProtocol.h"
#import "PersonReceiverProtocol.h"
#import "LunchReceiverProtocol.h"
#import "LunchCreationHandler.h"

@interface FoundBuddyViewController : UIViewController <LunchCreationHandler>
@property(nonatomic, strong) NSObject <PersonProtocol>  *personLoggedIn;
@property(nonatomic, strong) NSObject <PersonProtocol>  *buddy;

- (IBAction)createLunch:(id)sender;
@end
