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

@interface FoundBuddyViewController : UIViewController<PersonReceiverProtocol>
@property(nonatomic, strong) NSObject <PersonProtocol>  *buddy;
@end
