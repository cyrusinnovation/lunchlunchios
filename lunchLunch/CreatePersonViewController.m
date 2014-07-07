//
// Created by Cyrus on 7/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "CreatePersonViewController.h"
#import "CommandDispatcher.h"
#import "SegueCommand.h"
#import "CreatePersonSubController.h"
#import "PersonCreatorFactory.h"
#import "PersonCreatorProtocol.h"
#import "MainViewController.h"
#import "DisplayHandlerFactory.h"


@interface CreatePersonViewController ()
@property(nonatomic, strong) CreatePersonSubController *subController;
@end

@implementation CreatePersonViewController {


    NSObject <PersonProtocol> *personToLogin;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"createPersonSubController"]) {
        self.subController = (CreatePersonSubController *) segue.destinationViewController;
    }
    else if ([segue.identifier isEqualToString:@"loginSuccess"]) {
        UINavigationController *controller = segue.destinationViewController;
        MainViewController *mainViewController = (MainViewController *) [controller topViewController];
        mainViewController.personLoggedIn = personToLogin;
    }

}
-(BOOL) isValidEmail
{
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex =  laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self.subController.emailTextField.text];
}

- (IBAction)createButtonPressed:(id)sender {
    BOOL validEmail = [self isValidEmail];
    BOOL everythingIsFilledOut = [self requireFieldsAreFilledOut];
    if (everythingIsFilledOut && validEmail) {
        NSObject <PersonCreatorProtocol> *personCreator = [PersonCreatorFactory buildPersonCreator:self];
        NSString *firstName = self.subController.firstNameTextField.text;
        NSString *lastName = self.subController.lastNameTextField.text;
        NSString *email = self.subController.emailTextField.text;
        [personCreator createPersonWithFirstName:firstName lastName:lastName andEmail:email];
    }
    else if(!validEmail && everythingIsFilledOut){
        NSObject <DisplayHandlerProtocol> *displayHandler = [DisplayHandlerFactory buildDisplayHandler];
        [displayHandler showErrorWithMessage:@"Please enter a valid email address."];
    }
    else {
        NSObject <DisplayHandlerProtocol> *displayHandler = [DisplayHandlerFactory buildDisplayHandler];
        [displayHandler showErrorWithMessage:@"Please fill out all information before creating your user."];
    }

}

- (BOOL)requireFieldsAreFilledOut {

    return ![self.subController.firstNameTextField.text isEqualToString:@""]
            && ![self.subController.lastNameTextField.text isEqualToString:@""]
            && ![self.subController.emailTextField.text isEqualToString:@""];
}

- (IBAction)backButtonPressed:(id)sender {
    SegueCommand *segueCommand = [[SegueCommand alloc] initForViewController:self segueIdentifier:@"goBack"];
    [[CommandDispatcher singleton] executeCommand:segueCommand];
}

- (void)handlePersonFound:(NSObject <PersonProtocol> *)person {
    personToLogin = person;
    SegueCommand *segueCommand = [[SegueCommand alloc] initForViewController:self segueIdentifier:@"loginSuccess"];
    [[CommandDispatcher singleton] executeCommand:segueCommand];

}

- (void)handlePersonFoundError {
    NSObject <DisplayHandlerProtocol> *displayHandler = [DisplayHandlerFactory buildDisplayHandler];
    [displayHandler showErrorWithMessage:@"There was an error creating your user, it could be your email address is already in use."];
}

@end