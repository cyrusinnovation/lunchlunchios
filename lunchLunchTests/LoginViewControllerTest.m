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
#import "Person.h"
#import "NullPerson.h"
#import "MainViewController.h"
#import "LoginProviderFactoryTestHelper.h"
#import "MockLoginProvider.h"


@interface LoginViewControllerTest : XCTestCase

@property(nonatomic, strong) LoginViewController *viewController;
@property(nonatomic, strong) MockLoginProvider *loginProvider;
@end

@implementation LoginViewControllerTest {

}


- (void)setUp {
    [super setUp];
    self.viewController = [[LoginViewController alloc] init];

    [CommandDispatcherTestHelper swizzleExecute];
    [LoginProviderFactoryTestHelper swizzleBuildLoginProvider];
    self.loginProvider = [[MockLoginProvider alloc] init];
    [LoginProviderFactoryTestHelper setLoginProviderToReturn:self.loginProvider];
    self.viewController.emailTextField = [[UITextField alloc] init];
    self.viewController.errorLabel = [[UILabel alloc] init];

}

- (void)tearDown {
    [CommandDispatcherTestHelper deswizzleExecuteAndClearLastCommandExecuted];
    [LoginProviderFactoryTestHelper deswizzleBuildLoginProvider];
    self.viewController = nil;
    self.loginProvider = nil;
    [super tearDown];
}

- (void)testProtocols {
    XCTAssertTrue([LoginViewController conformsToProtocol:@protocol(UITextFieldDelegate)]);
    XCTAssertTrue([LoginViewController conformsToProtocol:@protocol(PersonReceiverProtocol)]);
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
    XCTAssertEqual(self.viewController, [LoginProviderFactoryTestHelper getPersonReceiverUsedToBuildLoginProvider]);
    XCTAssertEqualObjects(expectedEmailForSearch, [self.loginProvider getEmailUsedToFindPerson]);
}


- (void)testHandlePersonFoundWhenAPersonIsRetrievedWillFireSegueCommandWithLoginSuccess {

    XCTAssertNil([CommandDispatcherTestHelper getLastCommandExecuted]);

    [self.viewController handlePersonFound:[[Person alloc] init]];
    XCTAssertTrue([[CommandDispatcherTestHelper getLastCommandExecuted] isKindOfClass:[SegueCommand class]]);
    SegueCommand *command = (SegueCommand *) [CommandDispatcherTestHelper getLastCommandExecuted];
    XCTAssertEqualObjects(@"loginSuccess", [command getSegueIdentifier]);
    XCTAssertEqualObjects(self.viewController, [command getViewController]);

}

- (void)testHandlePersonFoundWhenANullPersonIsRetrievedWillNotFireSegueCommand {


    XCTAssertNil([CommandDispatcherTestHelper getLastCommandExecuted]);


    [self.viewController handlePersonFound:[NullPerson singleton]];
    XCTAssertNil([CommandDispatcherTestHelper getLastCommandExecuted]);


}

- (void)testHandlePersonFoundWhenANullPersonIsRetrievedWillShowErrorText {
    XCTAssertNil(self.viewController.errorLabel.text);

    [self.viewController handlePersonFound:[NullPerson singleton]];

    XCTAssertEqualObjects(@"Email does not exist", self.viewController.errorLabel.text);
}

- (void)testHandlePersonFoundItWillClearErrorTextWhenAPersonIsRetrieved {
    MockView *mockView = [[MockView alloc] init];
    self.viewController.view = mockView;

    self.viewController.errorLabel.text = @"You got an error yo";

    [self.viewController handlePersonFound:[[Person alloc] init]];
    XCTAssertNil(self.viewController.errorLabel.text);
}

- (void)testHandlePersonFound_WhenAPersonIsRetrievedItWillBePassedAlongToViewControllerOnTheSegue {

    XCTAssertNil([CommandDispatcherTestHelper getLastCommandExecuted]);
    Person *personFound = [[Person alloc] init];

    [self.viewController handlePersonFound:personFound];
    MainViewController *destinationViewController = [[MainViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:destinationViewController];
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"loginSuccess" source:self.viewController destination:navigationController];

    XCTAssertNil(destinationViewController.personLoggedIn);
    [self.viewController prepareForSegue:segue sender:self.viewController];

    XCTAssertEqual(personFound, destinationViewController.personLoggedIn);

}
@end
