//
//  HoursViewController.m
//  AramarkHelper
//
//  Created by Melissa Thai on 8/6/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import "HoursViewController.h"
#import "MainTabBarController.h"

@interface HoursViewController ()

@end

@implementation HoursViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MainTabBarController *mainTabBarController = (MainTabBarController *) self.tabBarController;
    if (mainTabBarController.dbAmount) {
        self.dbLabel.text = [NSString stringWithFormat:@"Your current DB: $%.2f", mainTabBarController.dbAmount];
    }
    
    [self.diningHallHoursView setHidden:NO];
    [self.worxHoursView setHidden:YES];
    [self.logansHoursView setHidden:YES];
    [self.subwayHoursView setHidden:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)selectedSegmentedControl:(id)sender {
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            [self.diningHallHoursView setHidden:NO];
            [self.worxHoursView setHidden:YES];
            [self.logansHoursView setHidden:YES];
            [self.subwayHoursView setHidden:YES];
            break;
        case 1:
            [self.diningHallHoursView setHidden:YES];
            [self.worxHoursView setHidden:NO];
            [self.logansHoursView setHidden:YES];
            [self.subwayHoursView setHidden:YES];
            break;
        case 2:
            [self.diningHallHoursView setHidden:YES];
            [self.worxHoursView setHidden:YES];
            [self.logansHoursView setHidden:NO];
            [self.subwayHoursView setHidden:YES];
            break;
        case 3:
            [self.diningHallHoursView setHidden:YES];
            [self.worxHoursView setHidden:YES];
            [self.logansHoursView setHidden:YES];
            [self.subwayHoursView setHidden:NO];
            break;
        default:
            break;
    }
}
@end
