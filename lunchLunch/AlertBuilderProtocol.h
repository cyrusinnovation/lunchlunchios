//
// Created by Cyrus on 4/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AlertBuilderProtocol <NSObject>
-(UIAlertView*) buildAlert:(NSString *) title message:(NSString *) message buttonTitle: (NSString*) buttonTitle;
@end