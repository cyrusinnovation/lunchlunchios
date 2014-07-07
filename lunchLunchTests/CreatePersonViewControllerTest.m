#import <XCTest/XCTest.h>
#import "CreatePersonViewController.h"
#import "CommandDispatcherTestHelper.h"
#import "SegueCommand.h"
#import "PersonReceiverProtocol.h"
#import "PersonCreatorFactoryTestHelper.h"
#import "CreatePersonSubController.h"
#import "MockPersonCreator.h"
#import "PersonCreatorFactory.h"
#import "Person.h"
#import "MainViewController.h"
#import "DisplayHandlerFactoryTestHelper.h"
#import "MockDisplayHandler.h"

@interface CreatePersonViewControllerTest : XCTestCase
@end

@interface CreatePersonViewControllerTest ()
@property(nonatomic, strong) CreatePersonViewController *viewController;
@end

@implementation CreatePersonViewControllerTest {

}
- (void)setUp {
    [super setUp];
    self.viewController = [[CreatePersonViewController alloc] init];
    [CommandDispatcherTestHelper swizzleExecute];
    [PersonCreatorFactoryTestHelper swizzleBuildPersonCreator];
    [DisplayHandlerFactoryTestHelper swizzleBuildDisplayHandler];
}

- (void)tearDown {
    [CommandDispatcherTestHelper deswizzleExecuteAndClearLastCommandExecuted];
    [DisplayHandlerFactoryTestHelper deswizzleBuildDisplayHandler];
    [PersonCreatorFactoryTestHelper deswizzleBuildPersonCreator];
}

- (void)testIsAPersonReceiver {
    XCTAssertTrue([CreatePersonViewController conformsToProtocol:@ protocol(PersonReceiverProtocol)]);
}

- (void)testBackButtonWillFireSegueCommandWithGoBack {
    XCTAssertNil([CommandDispatcherTestHelper getLastCommandExecuted]);
    [self.viewController backButtonPressed:nil];
    XCTAssertTrue([[CommandDispatcherTestHelper getLastCommandExecuted] isKindOfClass:[SegueCommand class]]);
    SegueCommand *command = (SegueCommand *) [CommandDispatcherTestHelper getLastCommandExecuted];
    XCTAssertEqualObjects(@"goBack", [command getSegueIdentifier]);
    XCTAssertEqualObjects(self.viewController, [command getViewController]);
}

- (void)testCreateButtonWillTakePersonInfoFromSubControllerAndPassItToThePersonCreator {

    CreatePersonSubController *destinationViewController = [self setupDestinationController];

    MockPersonCreator *personCreator = [[MockPersonCreator alloc] init];
    [PersonCreatorFactoryTestHelper setCreatorToReturn:personCreator];


    NSString *expectedFirstName = @"Rock";
    NSString *expectedLastName = @"Strongo";
    NSString *expectedEmailAddress = @"rstrongo@fakestreet.net";

    destinationViewController.firstNameTextField.text = expectedFirstName;
    destinationViewController.lastNameTextField.text = expectedLastName;
    destinationViewController.emailTextField.text = expectedEmailAddress;

    [self.viewController createButtonPressed:nil];
    XCTAssertEqualObjects(self.viewController, [PersonCreatorFactoryTestHelper getPersonReceiverUsedToBuildCreator]);

    XCTAssertEqualObjects(expectedFirstName, [personCreator getFirstNameForCreate]);
    XCTAssertEqualObjects(expectedLastName, [personCreator getLastNameForCreate]);
    XCTAssertEqualObjects(expectedEmailAddress, [personCreator getEmailForCreate]);
}

- (CreatePersonSubController *)setupDestinationController {
    CreatePersonSubController *destinationViewController = [[CreatePersonSubController alloc] init];
    UITextField *firstNameField = [[UITextField alloc] init];
    UITextField *lastNameField = [[UITextField alloc] init];
    UITextField *emailField = [[UITextField alloc] init];
    destinationViewController.firstNameTextField = firstNameField;
    destinationViewController.lastNameTextField = lastNameField;
    destinationViewController.emailTextField = emailField;
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"createPersonSubController" source:self.viewController destination:destinationViewController];

    [self.viewController prepareForSegue:segue sender:nil];
    return destinationViewController;
}

- (void)testHandlePersonFoundWillFireSegueCommand {

    XCTAssertNil([CommandDispatcherTestHelper getLastCommandExecuted]);
    [self.viewController handlePersonFound:[[Person alloc] init]];
    XCTAssertTrue([[CommandDispatcherTestHelper getLastCommandExecuted] isKindOfClass:[SegueCommand class]]);
    SegueCommand *command = (SegueCommand *) [CommandDispatcherTestHelper getLastCommandExecuted];
    XCTAssertEqualObjects(@"loginSuccess", [command getSegueIdentifier]);
    XCTAssertEqualObjects(self.viewController, [command getViewController]);
}

- (void)testLoginSuccessSegueWillPassPersonFoundToTheMainViewController {

    MainViewController *destinationViewController = [[MainViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:destinationViewController];

    Person *person = [[Person alloc] init];
    [self.viewController handlePersonFound:person];
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"loginSuccess" source:self.viewController destination:navigationController];
    [self.viewController prepareForSegue:segue sender:nil];

    XCTAssertEqual(person, [destinationViewController personLoggedIn]);

}

- (void)testCreatePersonErrorWillShowMessage {

    MockDisplayHandler *handler = [[MockDisplayHandler alloc] init];
    [DisplayHandlerFactoryTestHelper setDisplayHandlerToBuild:handler];
    [self.viewController handlePersonFoundError];

    XCTAssertEqualObjects(@"There was an error creating your user, it could be your email address is already in use.", [handler getErrorMessageShown]);
}

- (void)testTryingToClickCreateButtonWithoutFillingInAllInfoWillShowErrorMessage {

    MockDisplayHandler *handler = [[MockDisplayHandler alloc] init];
    [DisplayHandlerFactoryTestHelper setDisplayHandlerToBuild:handler];
    CreatePersonSubController *destinationViewController = [self setupDestinationController];
    [self checkErrorMessage:handler destinationViewController:destinationViewController firstName:@"" lastName:@"Strongo" email:@"rstrongo@fakestreet.net" errorMessage:@"Please fill out all information before creating your user."];
    [self checkErrorMessage:handler destinationViewController:destinationViewController firstName:@"Rock" lastName:@"" email:@"rstrongo@fakestreet.net" errorMessage:@"Please fill out all information before creating your user."];
    [self checkErrorMessage:handler destinationViewController:destinationViewController firstName:@"Rock" lastName:@"Strongo" email:@"" errorMessage:@"Please fill out all information before creating your user."];
}


- (void)testTryingToClickCreateButtonWithABadEmailAddressWillShowError {

    MockDisplayHandler *handler = [[MockDisplayHandler alloc] init];
    [DisplayHandlerFactoryTestHelper setDisplayHandlerToBuild:handler];
    CreatePersonSubController *destinationViewController = [self setupDestinationController];

    [self checkErrorMessage:handler destinationViewController:destinationViewController firstName:@"Rock" lastName:@"Strongo" email:@"noatsignmail.net" errorMessage:@"Please enter a valid email address."];
    [self checkErrorMessage:handler destinationViewController:destinationViewController firstName:@"Rock" lastName:@"Strongo" email:@"bad@stuff..net" errorMessage:@"Please enter a valid email address."];
    [self checkErrorMessage:handler destinationViewController:destinationViewController firstName:@"Rock" lastName:@"Strongo" email:@"nodot@net" errorMessage:@"Please enter a valid email address."];
    [self checkErrorMessage:handler destinationViewController:destinationViewController firstName:@"Rock" lastName:@"Strongo" email:@"neithrnet" errorMessage:@"Please enter a valid email address."];
    [self checkErrorMessage:handler destinationViewController:destinationViewController firstName:@"Rock" lastName:@"Strongo" email:@"thiswouldbestupid@.net" errorMessage:@"Please enter a valid email address."];
    [self checkErrorMessage:handler destinationViewController:destinationViewController firstName:@"Rock" lastName:@"Strongo" email:@"thiswouldbestupidnet@." errorMessage:@"Please enter a valid email address."];
    [self checkErrorMessage:handler destinationViewController:destinationViewController firstName:@"Rock" lastName:@"Strongo" email:@"@atanddotneedtobeinthemiddle." errorMessage:@"Please enter a valid email address."];


}

- (void)checkErrorMessage:(MockDisplayHandler *)handler destinationViewController:(CreatePersonSubController *)destinationViewController firstName:(NSString *)name lastName:(NSString *)lastName email:(NSString *)address errorMessage:(NSString *)expectedErrorMessage {
    [handler reset];
    destinationViewController.firstNameTextField.text = name;
    destinationViewController.lastNameTextField.text = lastName;
    destinationViewController.emailTextField.text = address;
    [self.viewController createButtonPressed:nil];
    XCTAssertEqualObjects(expectedErrorMessage, [handler getErrorMessageShown]);
}


@end