//
//  BuddyDetailViewController.m
//  lunchLunch
//
//  Created by Cyrus on 4/21/14.
//  Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "BuddyDetailViewController.h"

@interface BuddyDetailViewController ()

@end

@implementation BuddyDetailViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.firstNameLabel setText:[self.buddy getFirstName]];
    [self.lastNameLabel setText:[self.buddy getLastName]];
    [self.emailLabel setText:[self.buddy getEmailAddress]];
    NSDate *todayAtMidnight= [self getTodayAtMidnight];
    [self.datePicker setMinimumDate:todayAtMidnight ];

}

- (NSDate *)getTodayAtMidnight {
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSUInteger preservedComponents = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit);
    NSDate * todayAtMidnight = [calendar dateFromComponents:[calendar components:preservedComponents fromDate:today]];
    return todayAtMidnight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [UIView transitionWithView:self.datePickerCell
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];

    [self.datePickerCell setHidden:![self.datePickerCell isHidden]];
}

- (IBAction)dateValueChanged:(id)sender {
    self.date = [self.datePicker date] ;
    NSDateFormatter *dateStringGenerator = [[NSDateFormatter alloc] init];
    [dateStringGenerator setDateFormat:@"M/d/yyyy 'at' h:mm:a"];
    NSString *dateString = [dateStringGenerator stringFromDate:[self.datePicker date]];
    [self.dateLabel setText:dateString];
}

@end
