//
//  MainViewController.m
//  lunchLunch
//
//  Created by Cyrus on 4/2/14.
//  Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MainViewController.h"
#import "LoginProvider.h"
#import "PersonProtocol.h"
#import "Person.h"
#import "SegueCommand.h"
#import "CommandDispatcher.h"
#import "DetailViewController.h"
#import "LunchProviderFactory.h"
#import "FoundBuddyViewController.h"
#import "BuddyFinderProtocol.h"
#import "BuddyFinderFactory.h"
#import "DisplayHandlerFactory.h"

@interface MainViewController ()


@property(nonatomic, strong) NSObject <LunchProtocol> *detailedLunch;
@property(nonatomic, strong) NSArray *lunchesForPerson;

- (NSString *)buildLunchString:(NSObject <LunchProtocol> *)lunch;
- (NSString *)buildDateTimeString:(NSDate *)lunchTime;
@end

@implementation MainViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSObject <LunchProviderProtocol> *lunchProvider = [LunchProviderFactory buildLunchProvider:self];
    [lunchProvider findLunchesFor:self.personLoggedIn];

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
- (IBAction)findBuddyClicked:(id)sender{
    NSObject <BuddyFinderProtocol> *buddyFinder = [BuddyFinderFactory buildBuddyFinder:self];
    [buddyFinder findBuddyFor: self.personLoggedIn];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"seeDetails"]) {
        DetailViewController *controller = (DetailViewController *) segue.destinationViewController;
        controller.lunch = self.detailedLunch;
        controller.personLoggedIn = self.personLoggedIn;
    }
    if ([segue.identifier isEqualToString:@"findBuddy"]) {
        FoundBuddyViewController *controller = (FoundBuddyViewController *) segue.destinationViewController;
        controller.buddy = self.buddyFound;
        controller.personLoggedIn = self.personLoggedIn;
    }
}

- (void)handleLunchesFound:(NSArray *)lunches {
    self.lunchesForPerson = lunches;
    [self.lunchTable reloadData];
}

- (void)handlePersonFound:(NSObject <PersonProtocol> *)person {
    self.buddyFound = person;
    SegueCommand *segueCommand = [[SegueCommand alloc] initForViewController:self segueIdentifier:@"findBuddy"];
    [[CommandDispatcher singleton] executeCommand:segueCommand];
}

- (void)handlePersonFoundError {
    [[DisplayHandlerFactory buildDisplayHandler] showCommunicationError];
}


@end
