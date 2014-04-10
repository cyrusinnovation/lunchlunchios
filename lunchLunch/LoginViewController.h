//
//  LoginViewController.h
//  lunchLunch
//
//  Created by Cyrus on 4/3/14.
//  Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property(strong, nonatomic) IBOutlet UITextField *emailTextField;
- (IBAction)backgroundTap:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *errorLabel;

@end
