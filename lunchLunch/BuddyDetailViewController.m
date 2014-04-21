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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.firstNameLabel setText:[self.buddy getFirstName] ];
    [self.lastNameLabel setText:[self.buddy getLastName] ];
    [self.emailLabel setText:[self.buddy getEmailAddress] ];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
