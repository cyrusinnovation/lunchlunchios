//
// Created by Cyrus on 4/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockAlertBuilder.h"


@implementation MockAlertBuilder {

    UIAlertView *alertViewToReturn;
    NSString *buildAlertButtonTitle;
    NSString *buildAlertMessage;
    NSString *buildAlertTitle;
}
- (UIAlertView *)buildAlert:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle {
    buildAlertTitle = title;
    buildAlertMessage = message;
    buildAlertButtonTitle = buttonTitle;
    return alertViewToReturn;
}
-(void) setAlertViewToReturn:(UIAlertView *)viewToReturn{
    alertViewToReturn = viewToReturn;
}
-(NSString *)getBuiltAlertTitle{
    return buildAlertTitle;

}
-(NSString *)getBuiltAlertMessage{
    return buildAlertMessage;
}
-(NSString *)getBuiltAlertButtonTitle{
    return buildAlertButtonTitle;
}

@end