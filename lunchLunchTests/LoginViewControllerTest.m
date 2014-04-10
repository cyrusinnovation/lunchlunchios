//
//  LoginViewControllerTest.m
//  lunchLunch
//
//  Created by Cyrus on 4/3/14.
//  Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LoginViewController.h"
#import "MockUITextField.h"
#import "MockView.h"
#import "SwizzleHelper.h"
#import "CommandDispatcher.h"
#import "SegueCommand.h"
#import "CommandDispatcherTestHelper.h"
#import "PersonProviderTestHelper.h"
#import "Person.h"
#import "NullPerson.h"
#import "MainViewController.h"



@interface LoginViewControllerTest : XCTestCase

@property(nonatomic, strong) LoginViewController *viewController;
@end

@implementation LoginViewControllerTest

- (void)setUp {
    [super setUp];
    self.viewController = [[LoginViewController alloc] init];
    [PersonProviderTestHelper swizzleGetPerson];
    [CommandDispatcherTestHelper swizzleExecute];
    self.viewController.emailTextField = [[UITextField alloc] init];
    self.viewController.errorLabel = [[UILabel alloc] init];

}

- (void)tearDown {
    [PersonProviderTestHelper deswizzleGetPersonAndClearFields];
    [CommandDispatcherTestHelper deswizzleExecuteAndClearLastCommandExecuted];
    self.viewController = nil;
    [super tearDown];
}

- (void)testIsUITextFieldDelegate {
    XCTAssertTrue([LoginViewController conformsToProtocol:@protocol(UITextFieldDelegate)]);
}

- (void)testTextFieldShouldReturnResignsToFirstResponder {
    MockUITextField *mockTextField = [[MockUITextField alloc] init];
    XCTAssertFalse(mockTextField.resignFirstResponderWasCalled);

    XCTAssertTrue([self.viewController textFieldShouldReturn:mockTextField]);
    XCTAssertTrue(mockTextField.resignFirstResponderWasCalled);
}

- (void)testTapBackgroundWillEndEditing {
    MockView *mockView = [[MockView alloc] init];
    self.viewController.view = mockView;
    XCTAssertFalse(mockView.endEditingWasCalled);

    [self.viewController backgroundTap:nil];

    XCTAssertTrue(mockView.endEditingWasCalled);
    XCTAssertTrue(mockView.forceEndEditing);
}


- (void)testWhenTextFieldReturnsItWillUseTextFromEmailTextFieldToSearchForPerson {
    NSString *expectedEmailForSearch = @"heyguysthisiswhattosearchfor@altavista.com";
    self.viewController.emailTextField.text = expectedEmailForSearch;
    [self.viewController textFieldShouldReturn:[[UITextField alloc] init]];
    XCTAssertEqualObjects(expectedEmailForSearch, [PersonProviderTestHelper getEmailUsedToFindPerson]);
}


- (void)testWhenTextFieldReturns_WhenAPersonIsRetrievedWillFireSegueCommandWithLoginSuccess {

    XCTAssertNil([CommandDispatcherTestHelper getLastCommandExecuted]);
    [PersonProviderTestHelper setPersonToReturn:[[Person alloc] init]];

    [self.viewController textFieldShouldReturn:[[UITextField alloc] init]];
    XCTAssertTrue([[CommandDispatcherTestHelper getLastCommandExecuted] isKindOfClass:[SegueCommand class]]);
    SegueCommand *command = (SegueCommand *) [CommandDispatcherTestHelper getLastCommandExecuted];
    XCTAssertEqualObjects(@"loginSuccess", [command getSegueIdentifier]);
    XCTAssertEqualObjects(self.viewController, [command getViewController]);

}

- (void)testWhenTextFieldReturnsIt_WhenANullPersonIsRetrievedWillNotFireSegueCommand {

    XCTAssertNil([CommandDispatcherTestHelper getLastCommandExecuted]);
    [PersonProviderTestHelper setPersonToReturn:[NullPerson singleton]];

    [self.viewController textFieldShouldReturn:[[UITextField alloc] init]];
    XCTAssertNil([CommandDispatcherTestHelper getLastCommandExecuted]);


}

- (void)testWhenTextFieldReturnsIt_WhenANullPersonIsRetrievedWillShowErrorText {
    XCTAssertNil(self.viewController.errorLabel.text);
    [PersonProviderTestHelper setPersonToReturn:[NullPerson singleton]];

    [self.viewController textFieldShouldReturn:[[UITextField alloc] init]];

    XCTAssertEqualObjects(@"Email does not exist", self.viewController.errorLabel.text);
}

- (void)testWhenTextFieldReturnsItWillClearErrorTextWhenAPersonIsRetrieved {
    MockView *mockView = [[MockView alloc] init];
    self.viewController.view = mockView;

    self.viewController.errorLabel.text = @"You got an error yo";

    [PersonProviderTestHelper setPersonToReturn:[[Person alloc] init]];

    [self.viewController textFieldShouldReturn:[[UITextField alloc] init]];

    XCTAssertNil(self.viewController.errorLabel.text);
}

- (void)testWhenTextFieldReturns_WhenAPersonIsRetrievedItWillBePassedAlongToViewControllerOnTheSegue {

    XCTAssertNil([CommandDispatcherTestHelper getLastCommandExecuted]);
    Person *personFound = [[Person alloc] init];
    [PersonProviderTestHelper setPersonToReturn:personFound];

    [self.viewController textFieldShouldReturn:[[UITextField alloc] init]];
    MainViewController *destinationViewController = [[MainViewController alloc] init];
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController: destinationViewController];
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"loginSuccess" source:self.viewController destination:navigationController];

    XCTAssertNil(destinationViewController.personLoggedIn);
    [self.viewController prepareForSegue:segue sender:self.viewController];

    XCTAssertEqual(personFound, destinationViewController.personLoggedIn);

}
@end
