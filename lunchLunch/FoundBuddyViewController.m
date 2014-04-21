//
//  FindBuddyViewController.m
//  lunchLunch
//
//  Created by Cyrus on 4/21/14.
//  Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "PersonReceiverProtocol.h"
#import "FoundBuddyViewController.h"
#import "BuddyDetailViewController.h"

@interface FoundBuddyViewController ()

@end

@implementation FoundBuddyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handlePersonFound:(NSObject <PersonProtocol> *)person {

}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"buddyDetails"]) {
        BuddyDetailViewController *controller = (BuddyDetailViewController *) segue.destinationViewController;
        controller.buddy = self.buddy;
    }
}


@end
