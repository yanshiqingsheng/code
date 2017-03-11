//
//  ReportCompanyController.swift
//  kexin
//
//  Created by 维高 on 16/10/26.
//  Copyright © 2016年 维高. All rights reserved.
//

import UIKit

class ReportCompanyController : UITableViewController {
    
    var reportcompanys:[ReportCompany] = []
    
    
    let companyHandler = HttpHandler()
    
    
    var pageNum: Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        reportcompanys = HttpHandler.getReportCompanys()
        
        self.tableView.estimatedRowHeight = 10.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        //print(companys.count)
        //tableView.backgroundColor = UIColor.blue
        
       
        self.setupRefresh()
        
    }
    
    
    
    func setupRefresh(){
        self.tableView.addHeaderWithCallback({
            let tempcompanys = HttpHandler.getReportCompanys()
            if(tempcompanys.count != 0)
            {
                self.reportcompanys = tempcompanys
            }
            
            let delayInSeconds:Int64 =  100000000  * 2
            
            
            let popTime:DispatchTime = DispatchTime.now() + Double(delayInSeconds) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: popTime, execute: {
                self.tableView.reloadData()
                self.tableView.headerEndRefreshing()
            })
            
        })
        
        
          }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        
        
                    return reportcompanys.count
      
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        
        let com =  reportcompanys[indexPath.row]
        
        
        // Configure the cell...
        cell.textLabel?.text = com.title! + "\n" + com.create_time! + "               " + com.status!
        // Solution to the exercise
        //cell.imageView?.image = UIImage(named: companys[indexPath.row])
        
        // Uncomment the line below (i.e. removing //) if you just want to display the same image
        // cell.imageView?.image = UIImage(named: "restaurant")
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReportCompanyDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! ReportCompanyDetailController
                
                let com =  reportcompanys[indexPath.row]
                destinationController.id  =  com.id
                           }
        }
    }
    
    
   
    
}

