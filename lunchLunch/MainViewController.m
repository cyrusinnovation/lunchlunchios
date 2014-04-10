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

@interface MainViewController ()


- (NSString *)buildLunchString:(NSObject <LunchProtocol> *)lunch;

- (NSObject <PersonProtocol> *)findLunchBuddy:(NSObject <LunchProtocol> *)lunch;

- (NSString *)buildDateTimeString:(NSDate *)lunchTime;
@end

@implementation MainViewController {
    NSArray *lunchesForPerson;
}

- (id)init {
    self = [super initWithNibName:@"MainViewController" bundle:[NSBundle bundleForClass:[self class]]];
    if (self) {

    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    LunchProvider *provider = [[LunchProvider alloc] initWithLunchRetriever:[[LunchRetriever alloc] init]];
    lunchesForPerson = [provider findLunchesFor:self.personLoggedIn];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [lunchesForPerson count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LunchCell" forIndexPath:indexPath];
    NSObject <LunchProtocol> *lunch = [lunchesForPerson objectAtIndex:indexPath.row];
    NSString *lunchString = [self buildLunchString:lunch];
    cell.textLabel.text = lunchString;
    return cell;
}

- (NSString *)buildLunchString:(NSObject <LunchProtocol> *)lunch {
    NSObject <PersonProtocol> *lunchBuddy = [self findLunchBuddy:lunch];
    NSString *dateTimeString = [self buildDateTimeString:[lunch getDateAndTime]];
    NSString *lunchString = [NSString localizedStringWithFormat:@"With %@ %@ on %@", [lunchBuddy getFirstName], [lunchBuddy getLastName], dateTimeString];
    return lunchString;
}

- (NSObject <PersonProtocol> *)findLunchBuddy:(NSObject <LunchProtocol> *)lunch {
    if([[lunch getPerson1] isEqual: self.personLoggedIn]){
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

@end
