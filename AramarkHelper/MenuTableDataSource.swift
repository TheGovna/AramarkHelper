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

class MenuTableDataSource:NSObject, UITableViewDataSource{
    
    class CategoryWithFood {
        var name:NSString
        var foods:[String]
        
        init(name : NSString){
            self.name = name
            self.foods = []
        }
    }
    
    var view : UITableView
    var date : NSDate
    var periodTag : Int
    var periodName : NSString
    var categoryWithFoods : [CategoryWithFood]
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return categoryWithFoods.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categoryWithFoods[section].name as String
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryWithFoods[section].foods.count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        cell.textLabel?.text = categoryWithFoods[indexPath.section].foods[indexPath.row]
        return cell;
    }
   
    init(date : NSDate, periodTag : Int, tView : UITableView) {
        self.date = date
        self.periodTag = periodTag
        if  periodTag == 0{
            periodName = "Breakfast"
        } else if periodTag == 1{
            periodName = "Lunch"
        } else {
            periodName = "Dinner"
        }
        categoryWithFoods = []
        self.view = tView
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
                    let dishQuery = GTLQueryAramarkHelperMenuFetcher.queryForDishListWithParent(category.entityKey as String);
                    service.executeQuery(dishQuery, completionHandler: { (dTicket, dResponse, dError) -> Void in
                        let newCategoryWF = CategoryWithFood(name:category.name)
                        let dishCollection = dResponse as! GTLAramarkHelperMenuFetcherDishCollection
                        if let dishes = dishCollection.items() as? [GTLAramarkHelperMenuFetcherDish]{
                            for dish in dishes{
                                println(dish.name)
                                newCategoryWF.foods.append(dish.name)
                            }
                            self.categoryWithFoods.append(newCategoryWF)
                            println(self.categoryWithFoods.count)
                            self.view.reloadData()
                        }
                    })
                }
            }
        })
    }
}
