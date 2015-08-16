//
//  DayMenuViewController.swift
//  AramarkHelper
//
//  Created by CSSE Department on 8/14/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

import UIKit

@objc class DayMenuViewController: UIViewController {

    @IBOutlet weak var periodSegment: UISegmentedControl!
    @IBOutlet weak var dbLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var menuTableView: UITableView!
    
    var menuDataSource : MenuTableDataSource?
    
    @IBAction func selectedPeriod(sender: AnyObject) {
        updateTable()
    }
    var date : NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var mainTabBarController : MainTabBarController = self.tabBarController as! MainTabBarController;
        var dbAmount : String = String(format: "%.2f", mainTabBarController.dbAmount)
        self.dbLabel.text = "Your current DB: $\(dbAmount)"
    }

    override func viewWillAppear(animated: Bool) {
        if self.date == nil{
            self.date = NSDate()
        }
        var usLocale = NSLocale(localeIdentifier: "en_US")
        var dateFormatter = NSDateFormatter()
        dateFormatter.locale = usLocale
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        self.dateLabel.text = "Menu for \(dateFormatter.stringFromDate(self.date!))"
        updateTable()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Private helper function
    
    func updateTable(){
        println("selected : \(periodSegment.selectedSegmentIndex)")
        menuDataSource = MenuTableDataSource(date: self.date!, periodTag: periodSegment.selectedSegmentIndex, tView: self.menuTableView)
        menuDataSource!.periodTag = periodSegment.selectedSegmentIndex
        menuTableView.dataSource = menuDataSource
        menuTableView.reloadData()
    }
    
    
}
