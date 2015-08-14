//
//  MenuTableDataSource.swift
//  AramarkHelper
//
//  Created by CSSE Department on 8/14/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

import UIKit

class MenuTableDataSource:NSObject, UITableViewDataSource, UITableViewDelegate{
    
    var date : NSDate
    var periodTag : Int
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        var period:NSString
        if  periodTag == 0{
            period = "Breakfast"
        } else if periodTag == 1{
            period = "Lunch"
        } else {
            period = "Dinner"
        }
        cell.textLabel?.text = "\(period)";
        return cell;
    }
   
    override init() {
        self.date = NSDate()
        self.periodTag = 1
        super.init()
    }
}
