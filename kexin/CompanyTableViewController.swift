//
//  CompanyTableViewController.swift
//  kexin
//
//  Created by 维高 on 16/10/9.
//  Copyright © 2016年 维高. All rights reserved.
//

import UIKit

class CompanyTableViewController : UITableViewController , UISearchResultsUpdating {

    var companys:[Company] = []
    var searchCompanys:[Company] = []
    let companyHandler = HttpHandler()
    var searchController: UISearchController!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        companys = companyHandler.getCompanys(keywords: "")
        searchCompanys = companys
        self.tableView.estimatedRowHeight = 10.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        //print(companys.count)
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        
        //tableView.backgroundColor = UIColor.blue
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "查找企业..."
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        
        
        if searchController.isActive {
            return searchCompanys.count
        } else {
            return companys.count
        }

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        
        let com = (searchController.isActive) ? searchCompanys[indexPath.row] : companys[indexPath.row]
        
        
        // Configure the cell...
        cell.textLabel?.text = com.com_name! + "\n企业类型：" + com.role_type! + "\n企业地址：" + com.reg_address! + "\n商品数量：" + com.product_num!
        
        // Solution to the exercise
        //cell.imageView?.image = UIImage(named: companys[indexPath.row])
        
        // Uncomment the line below (i.e. removing //) if you just want to display the same image
        // cell.imageView?.image = UIImage(named: "restaurant")
        
        return cell
    }

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
    
    
    func filterContent(for searchText: String) {
        searchCompanys = companyHandler.getCompanys(keywords: searchText)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            
            tableView.reloadData()
        }
    }

}
