//
//  MenuTableDataSource.swift
//  AramarkHelper
//
//  Created by CSSE Department on 8/14/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

import UIKit

var service : GTLServiceAramarkHelperMenuFetcher{
    if _service != nil{
        return _service!
    }
    _service = GTLServiceAramarkHelperMenuFetcher()
    _service?.retryEnabled = true
    _service?.apiVersion = "v1"
    
    return _service!
}
var _service : GTLServiceAramarkHelperMenuFetcher?

class MenuTableDataSource:NSObject, UITableViewDataSource, UITableViewDelegate{
    
    var date : NSDate
    var periodTag : Int
    var periodName : NSString
    
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
   
    init(date : NSDate, periodTag : Int) {
        self.date = date
        self.periodTag = periodTag
        if  periodTag == 0{
            periodName = "Breakfast"
        } else if periodTag == 1{
            periodName = "Lunch"
        } else {
            periodName = "Dinner"
        }
        super.init()
        _fetchDatafromServer()
    }
    
    //MARK: -- self helper methods
    
    func _fetchDatafromServer(){
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        println(dateFormatter.stringFromDate(self.date))
        let query = GTLQueryAramarkHelperMenuFetcher.queryForPeriodListWithSelectDate(dateFormatter.stringFromDate(self.date))
        service.executeQuery(query, completionHandler: { (ticket, response, error) -> Void in
            let periodCollection = response as! GTLAramarkHelperMenuFetcherPeriodCollection
            if let periods = periodCollection.items() as? [GTLAramarkHelperMenuFetcherPeriod]{
                for period in periods{
                    if(period.name==self.periodName){
                        self._queryForCategoriesInPeriod(period.entityKey)
                    }
                }
            }
        })
    }
    
    func _queryForCategoriesInPeriod(periodKey : NSString){
        let query = GTLQueryAramarkHelperMenuFetcher.queryForCategoryListWithParent(periodKey as String)
        service.executeQuery(query, completionHandler: { (ticket, response, error) -> Void in
            let categoryCollection = response as! GTLAramarkHelperMenuFetcherCategoryCollection
            if let categories = categoryCollection.items() as? [GTLAramarkHelperMenuFetcherCategory]{
                for category in categories{
                    println(category.name)
                }
            }
        })
    }
}
