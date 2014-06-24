//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LocationSelectionController.h"
#import "LocationProviderFactoryTestHelper.h"
#import "CommandDispatcherTestHelper.h"
#import "MockLocationProvider.h"
#import "Location.h"
#import "MockUITableView.h"

@interface LocationSelectionControllerTest : XCTestCase
@end

@interface LocationSelectionControllerTest ()
@property(nonatomic, strong) LocationSelectionController *viewController;
@end

@implementation LocationSelectionControllerTest {

}

- (void)setUp {
    [super setUp];
    self.viewController = [[LocationSelectionController alloc] init];
    [LocationProviderFactoryTestHelper swizzleBuildLocationProvider];
    [CommandDispatcherTestHelper swizzleExecute];

}

- (void)tearDown {
    [LocationProviderFactoryTestHelper deswizzleBuildLocationProvider];
    [CommandDispatcherTestHelper deswizzleExecuteAndClearLastCommandExecuted];
    self.viewController = nil;
    [super tearDown];
}

- (void)testHasCorrectProtocols {
    XCTAssertTrue([LocationSelectionController conformsToProtocol:@ protocol(LocationReceiverProtocol)]);
    XCTAssertTrue([LocationSelectionController conformsToProtocol:@ protocol(UITableViewDelegate)]);
    XCTAssertTrue([LocationSelectionController conformsToProtocol:@ protocol(UITableViewDataSource)]);
}

- (void)testWillFindLocationsWhenViewDidLoad {

    MockLocationProvider *locationProvider = [[MockLocationProvider alloc] init];
    [LocationProviderFactoryTestHelper setLocationProviderToReturn:locationProvider];
    [self.viewController viewDidLoad];
    XCTAssertEqual(self.viewController, [LocationProviderFactoryTestHelper getLocationReceiverUsedToBuildProvider]);
    XCTAssertTrue([locationProvider wasGetAllLocationsCalled]);
}

- (void)testUsesFoundListOfLocationsToProvideNumberOfRows {
    NSArray *locationsFound = [NSArray arrayWithObjects:[[Location alloc] init], [[Location alloc] init], [[Location alloc] init], [[Location alloc] init], [[Location alloc] init], [[Location alloc] init], [[Location alloc] init], nil];

    [self.viewController handleLocationsFound: locationsFound];

    XCTAssertEqual([locationsFound count], [self.viewController tableView:nil numberOfRowsInSection:0] );
}

- (void)testHandleLocationsFoundWillTellTableToReload {
    MockUITableView *mockTable = [[MockUITableView alloc] init];
    self.viewController.locationTable = mockTable;

    [self.viewController handleLocationsFound:@[[[Location alloc] init]]];

    XCTAssertTrue([mockTable wasReloadDataCalled]);
}

- (void)testCellForRowAtIndexPathWillSetLunchFromThatCell {


    Location *location = [[Location alloc] init];

    NSString *locationName = @"Fogo De Chao";
    Location *locationToUse = [[Location alloc] initWithId:@"56452" name:locationName address:@"40 W 53rd St" andZipCode:@"10019"];
    [self.viewController handleLocationsFound:@[location,location,location,location,locationToUse,location]];

    MockUITableView *tableView = [[MockUITableView alloc] init];
    UITableViewCell *cellToReturn = [[UITableViewCell alloc] init];
    [tableView setCellToReturn:cellToReturn];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:4 inSection:1];



    [self checkViewCellBuilt:tableView cellToReturn:cellToReturn indexPath:indexPath expectedText:locationName];
}

- (void)checkViewCellBuilt:(MockUITableView *)tableView cellToReturn:(UITableViewCell *)cellToReturn indexPath:(NSIndexPath *)indexPath expectedText:(NSString *)expectedText {
    UITableViewCell *viewCell = [self.viewController tableView:tableView cellForRowAtIndexPath:indexPath];
    XCTAssertEqualObjects(cellToReturn, viewCell);
    XCTAssertEqualObjects(@"LocationCell", [tableView getIdentifierForDequeue]);
    XCTAssertEqualObjects(indexPath, [tableView getIndexPathForDequeue]);
    XCTAssertEqualObjects(expectedText, cellToReturn.textLabel.text);
}


@end