//
// Created by Cyrus on 4/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "DisplayHandler.h"


@implementation DisplayHandler {

    NSObject <AlertBuilderProtocol> *alertBuilder;
}
- (id)initWithAlertBuilder:(NSObject <AlertBuilderProtocol> *)builder {
    self = [super init];
    if (self) {
        alertBuilder = builder;
    }
    return self;
}

- (NSObject <AlertBuilderProtocol> *)getAlertBuilder {
    return alertBuilder;
}


- (void)showCommunicationError {
    UIAlertView *view = [alertBuilder buildAlert:@"Communication Error"
                                         message:@"Error communicating with web service, please ensure you are connected to the internet and try again" buttonTitle:@"OK"];
    [view show];

}

- (void)showErrorWithMessage:(NSString *)message {
    UIAlertView *view = [alertBuilder buildAlert:@"Error"
                                         message:message buttonTitle:@"OK"];
    [view show];
}

@end