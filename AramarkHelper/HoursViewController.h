//
//  HoursViewController.h
//  AramarkHelper
//
//  Created by Melissa Thai on 8/6/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HoursViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *dbLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UIView *diningHallHoursView;
@property (weak, nonatomic) IBOutlet UIView *worxHoursView;
@property (weak, nonatomic) IBOutlet UIView *logansHoursView;
@property (weak, nonatomic) IBOutlet UIView *subwayHoursView;

- (IBAction)selectedSegmentedControl:(id)sender;
- (IBAction)pressedLogoutButton:(id)sender;

@end
