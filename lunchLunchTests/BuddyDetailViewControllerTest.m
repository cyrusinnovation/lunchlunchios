//
// Created by Cyrus on 4/21/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "Person.h"
#import "BuddyDetailViewController.h"
#import "AnimationTestHelper.h"

@interface BuddyDetailViewControllerTest : XCTestCase

@property(nonatomic, strong) BuddyDetailViewController *viewController;

@end

@implementation BuddyDetailViewControllerTest {

}
- (void)setUp {
    [super setUp];
    self.viewController = [[BuddyDetailViewController alloc] init];
    self.viewController.firstNameLabel = [[UILabel alloc] init];
    self.viewController.lastNameLabel = [[UILabel alloc] init];
    self.viewController.emailLabel = [[UILabel alloc] init];
    [AnimationTestHelper swizzleTransitionWithView];
}

- (void)tearDown {
    [AnimationTestHelper deswizzleTransitionWithView];
    self.viewController = nil;
    [super tearDown];
}

- (void)testWillShowLunchDetailsOnViewDidLoad {
    NSString *firstName = @"Brock";
    NSString *lastName = @"Thickneck";
    NSString *email = @"BThick@mstk.net";
    Person *buddyFound = [[Person alloc] initWithFirstNameInitWithId:@"346234" firstName:firstName lastName:lastName email:email];

    self.viewController.buddy = buddyFound;

    [self.viewController viewDidLoad];
    XCTAssertEqualObjects(firstName, [self.viewController.firstNameLabel text]);
    XCTAssertEqualObjects(lastName, [self.viewController.lastNameLabel text]);
    XCTAssertEqualObjects(email, [self.viewController.emailLabel text]);
}

- (void)testSetsDateSelectorMinDateToTodayOnViewDidLoad {

    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSUInteger preservedComponents = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit);
    NSDate * todayAtMidnight = [calendar dateFromComponents:[calendar components:preservedComponents fromDate:today]];
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    self.viewController.datePicker = datePicker;

    [self.viewController viewDidLoad];
    XCTAssertEqualObjects(todayAtMidnight, [datePicker minimumDate]);
}


- (void)testWillShowDatePickerCellOnSelectionOfSelectDateCellWithAnimation {
    UITableView *table = [[UITableView alloc] init];
    UITableViewCell *datePickerCell = [[UITableViewCell alloc] init];
    [datePickerCell setHidden:true];
    self.viewController.datePickerCell = datePickerCell;

    XCTAssertTrue([datePickerCell isHidden]);

    NSIndexPath *indexPathOfSelectDateCell = [NSIndexPath indexPathForRow:1 inSection:2];
    [self.viewController tableView:table didSelectRowAtIndexPath:indexPathOfSelectDateCell];
    XCTAssertFalse([datePickerCell isHidden]);
    XCTAssertEqual(datePickerCell, [AnimationTestHelper getViewToTransition]);
    XCTAssertEqual(0.4, [AnimationTestHelper getDurationForTransition]);
    XCTAssertEqual(UIViewAnimationOptionTransitionCrossDissolve, [AnimationTestHelper getAnimationOptionForTransition]);
    [self.viewController tableView:table didSelectRowAtIndexPath:indexPathOfSelectDateCell];

    XCTAssertTrue([datePickerCell isHidden]);
}

- (void)testWhenDateIsChangedItWillUpdateTheDateLabel {
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    self.viewController.datePicker = datePicker;
    self.viewController.dateLabel = [[UILabel alloc] init];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSDate *date = [formatter dateFromString:@"12/12/1212"];

    [datePicker setDate:date];
    [self.viewController dateValueChanged:datePicker];

    NSDateFormatter *dateStringGenerator = [[NSDateFormatter alloc] init];
    [dateStringGenerator setDateFormat:@"M/d/yyyy 'at' h:mm:a"];
    NSString *dateString = [dateStringGenerator stringFromDate:date];
    XCTAssertEqualObjects(dateString, [[self.viewController dateLabel] text]);
}

- (void)testWhenDateIsChangedItWillSetTheDateOnViewController {

    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    self.viewController.datePicker = datePicker;


    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSDate *date = [formatter dateFromString:@"12/12/1212"];
    [datePicker setDate:date];

    [self.viewController dateValueChanged:nil];
    XCTAssertEqualObjects(date, self.viewController.date);

}
@end