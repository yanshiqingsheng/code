//
//  WarningTableController.swift
//  kexin
//
//  Created by 维高 on 16/10/23.
//  Copyright © 2016年 维高. All rights reserved.
//

import UIKit

class WarningTableController : UITableViewController , UISearchResultsUpdating {
    
    var warnings:[WarningInfo] = []
    var searchwarnings:[WarningInfo] = []
    let warningsHandler = HttpHandler()
    var searchController: UISearchController!
    var pageNum: Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        warnings = warningsHandler.getWarnings("", pageNum: pageNum)
        searchwarnings = warnings
        self.tableView.estimatedRowHeight = 10.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        //print(companys.count)
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        
        //tableView.backgroundColor = UIColor.blue
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "请输入关键字"
        self.setupRefresh()
        
    }
    
    
    
    func setupRefresh(){
        self.tableView.addHeaderWithCallback({
            let tempcompanys = self.warningsHandler.getWarnings("", pageNum: 1)
            if(tempcompanys.count != 0)
            {
                self.warnings = tempcompanys
            }
            
            let delayInSeconds:Int64 =  100000000  * 2
            
            
            let popTime:DispatchTime = DispatchTime.now() + Double(delayInSeconds) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: popTime, execute: {
                self.tableView.reloadData()
                self.tableView.headerEndRefreshing()
            })
            
        })
        
        
        self.tableView.addFooterWithCallback({
            
            self.pageNum = self.pageNum + 1
            let tempcompanys = self.warningsHandler.getWarnings("", pageNum: self.pageNum)
            if(tempcompanys.count != 0)
            {
                self.warnings.append(contentsOf: tempcompanys)
            }
            let delayInSeconds:Int64 = 100000000 * 2
            let popTime:DispatchTime = DispatchTime.now() + Double(delayInSeconds) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: popTime, execute: {
                self.tableView.reloadData()
                self.tableView.footerEndRefreshing()
                
                //self.tableView.setFooterHidden(true)
            })
        })
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        
        
        if searchController.isActive {
            return searchwarnings.count
        } else {
            return warnings.count
        }
        
    }
    func getNilString(_ tmp:String?)->String
    {
        if tmp == nil
        {
            return ""
        }else
        {
            return tmp!
        }
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        
        let com = (searchController.isActive) ? searchwarnings[indexPath.row] : warnings[indexPath.row]
        
        
        // Configure the cell...
        cell.textLabel?.text = getNilString(com.title) + "\n发布单位：" + getNilString(com.publish_department) + "\n发布时间：" + getNilString(com.publish_time)
        
        // Solution to the exercise
        //cell.imageView?.image = UIImage(named: companys[indexPath.row])
        
        // Uncomment the line below (i.e. removing //) if you just want to display the same image
        // cell.imageView?.image = UIImage(named: "restaurant")
        
        return cell
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCompanyDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! CompanyDetailTableViewController
                
                let com = (searchController.isActive) ? searchCompanys[indexPath.row] : companys[indexPath.row]
                destinationController.id  =  com.eid
                destinationController.record_no =  com.record_no
            }
        }
    }
    */
    
    func filterContent(for searchText: String) {
        searchwarnings = warningsHandler.getWarnings(searchText, pageNum: 1)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            
            tableView.reloadData()
        }
    }
    
}

