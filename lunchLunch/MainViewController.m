//
//  MainViewController.m
//  lunchLunch
//
//  Created by Cyrus on 4/2/14.
//  Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MainViewController.h"
#import "PersonProvider.h"
#import "PersonProtocol.h"
#import "Person.h"
#import "LunchProvider.h"
#import "LunchRetriever.h"
#import "SegueCommand.h"
#import "CommandDispatcher.h"
#import "DetailViewController.h"

@interface MainViewController ()


@property(nonatomic, strong) NSObject <LunchProtocol> *detailedLunch;
@property(nonatomic, strong) NSArray *lunchesForPerson;

- (NSString *)buildLunchString:(NSObject <LunchProtocol> *)lunch;

- (NSObject <PersonProtocol> *)findLunchBuddy:(NSObject <LunchProtocol> *)lunch;

- (NSString *)buildDateTimeString:(NSDate *)lunchTime;
@end

@implementation MainViewController {


}

- (void)viewDidLoad {
    [super viewDidLoad];
    LunchProvider *provider = [[LunchProvider alloc] initWithLunchRetriever:[[LunchRetriever alloc] init]];
    self.lunchesForPerson = [provider findLunchesFor:self.personLoggedIn];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.lunchesForPerson count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LunchCell" forIndexPath:indexPath];
    NSObject <LunchProtocol> *lunch = [self.lunchesForPerson objectAtIndex:indexPath.row];
    NSString *lunchString = [self buildLunchString:lunch];
    cell.textLabel.text = lunchString;
    return cell;
}

- (NSString *)buildLunchString:(NSObject <LunchProtocol> *)lunch {
    NSString *dateTimeString = [self buildDateTimeString:[lunch getDateAndTime]];
    NSString *lunchString = dateTimeString;
    return lunchString;
}

- (NSObject <PersonProtocol> *)findLunchBuddy:(NSObject <LunchProtocol> *)lunch {
    if ([[lunch getPerson1] isEqual:self.personLoggedIn]) {
        return [lunch getPerson2];
    }
    return [lunch getPerson1];

}

- (NSString *)buildDateTimeString:(NSDate *)lunchTime {
    NSDateFormatter *dateStringGenerator = [[NSDateFormatter alloc] init];
    [dateStringGenerator setDateFormat:@"M/d/yyyy"];
    NSString *dateString = [dateStringGenerator stringFromDate:lunchTime];
    [dateStringGenerator setDateFormat:@"h:mm a"];
    NSString *timeString = [dateStringGenerator stringFromDate:lunchTime];
    return [NSString localizedStringWithFormat:@"%@ at %@", dateString, timeString];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.detailedLunch = [self.lunchesForPerson objectAtIndex:indexPath.row];
    SegueCommand *segueCommand = [[SegueCommand alloc] initForViewController:self segueIdentifier:@"seeDetails"];
    [[CommandDispatcher singleton] executeCommand:segueCommand];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"seeDetails"]) {
        DetailViewController *controller = (DetailViewController *) segue.destinationViewController;
        controller.lunch = self.detailedLunch;
        controller.personLoggedIn = self.personLoggedIn;
    }
}

@end
