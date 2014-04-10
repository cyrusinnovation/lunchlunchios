//
// Created by Cyrus on 4/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MockViewController : UIViewController
    @property(nonatomic, copy) NSString *segueToPerform;
    @property(nonatomic, strong) id senderForPerformSegue;
@end