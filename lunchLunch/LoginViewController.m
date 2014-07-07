//
//  LoginViewController.m
//  lunchLunch
//
//  Created by Cyrus on 4/3/14.
//  Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LoginViewController.h"
#import "CommandDispatcher.h"
#import "SegueCommand.h"
#import "LoginProvider.h"

#import "NullPerson.h"
#import "MainViewController.h"
#import "LoginProviderFactory.h"
#import "DisplayHandlerFactory.h"

@interface LoginViewController ()
@property(nonatomic) NSObject <PersonProtocol> *personFound;
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)createNewAccount:(id)sender {
    SegueCommand *segueCommand = [[SegueCommand alloc] initForViewController:self segueIdentifier:@"createPerson"];
    [[CommandDispatcher singleton] executeCommand:segueCommand];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    NSString *emailToFind = self.emailTextField.text;
    NSObject <LoginProviderProtocol> *loginProvider = [LoginProviderFactory buildLoginProvider:self];
    [loginProvider findPersonByEmail:emailToFind];
    return YES;
}


- (void)handlePersonFound:(NSObject <PersonProtocol> *)person {
    self.personFound = person;
    if (![self.personFound isEqual:[NullPerson singleton]]) {
        SegueCommand *segueCommand = [[SegueCommand alloc] initForViewController:self segueIdentifier:@"loginSuccess"];
        [[CommandDispatcher singleton] executeCommand:segueCommand];
    }
    else {
        [[DisplayHandlerFactory buildDisplayHandler] showErrorWithMessage:@"The email you entered does not exist, please try again"];
    }
}

- (void)handlePersonFoundError {
    [[DisplayHandlerFactory buildDisplayHandler] showCommunicationError];
}


- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:true];

}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"loginSuccess"]) {
        UINavigationController *controller = segue.destinationViewController;
        MainViewController *mainViewController = (MainViewController *) [controller topViewController];
        mainViewController.personLoggedIn = self.personFound;
    }
}


@end
