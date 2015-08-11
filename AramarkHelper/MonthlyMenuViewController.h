//
//  SecondViewController.h
//  AramarkHelper
//
//  Created by Melissa Thai on 8/5/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JTCalendar/JTCalendar.h>

@interface MonthlyMenuViewController : UIViewController <JTCalendarDelegate>

@property (weak, nonatomic) IBOutlet UILabel *dbLabel;

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@end

