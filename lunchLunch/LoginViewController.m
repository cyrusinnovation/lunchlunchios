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
#import "PersonProvider.h"
#import "PersonRetriever.h"
#import "NullPerson.h"
#import "MainViewController.h"
#import "Person.h"

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];

    PersonProvider *provider = [[PersonProvider alloc] initWithRetriever:[[PersonRetriever alloc] init]];
    NSString *emailToFind = self.emailTextField.text;
    self.personFound = [provider findPersonByEmail:emailToFind];
    if (![self.personFound isEqual:[NullPerson singleton]]) {
        self.errorLabel.text = nil;
        SegueCommand *segueCommand = [[SegueCommand alloc] initForViewController:self segueIdentifier:@"loginSuccess"];
        [[CommandDispatcher singleton] executeCommand:segueCommand];
    }
    else {
        self.errorLabel.text = @"Email does not exist";
    }
    return YES;
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:true];

}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"loginSuccess"]) {
        UINavigationController * controller = segue.destinationViewController;
        MainViewController *mainViewController = (MainViewController*)[controller topViewController];
        mainViewController.personLoggedIn = self.personFound;
    }
}


@end
