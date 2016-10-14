//
//  CompanyDetailTableViewController.swift
//  kexin
//
//  Created by 维高 on 16/10/13.
//  Copyright © 2016年 维高. All rights reserved.
//

import UIKit

class CompanyDetailTableViewController : UITableViewController {
    
    var companyDetail : CompanyDetail?
    let companyDetailHandler = HttpHandler()
    var id : String?
    var record_no : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        companyDetail = companyDetailHandler.getCompanyDetails(id:id!,record_no:record_no!)
        self.tableView.estimatedRowHeight = 10.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        //print(id)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 1
    }
    
    func getNilString(tmp:String?)->String
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
        var tmp1: String = getNilString(tmp: companyDetail!.com_name)
                           + "\n\n基本信息"
                           + "\n企业类型：                    " + getNilString(tmp: companyDetail!.role_type)
                           + "\n所在地区：                    " + getNilString(tmp: companyDetail!.address)
                           + "\n是否有直接进口业务："             + getNilString(tmp: companyDetail!.is_manu_import)
        var tmp2: String =   "\n许可范围：                "     + getNilString(tmp: companyDetail!.real_business_scope)
                           + "\n是否有门户网站：        "        + getNilString(tmp: companyDetail!.have_site?.description)
                           + "\n\n工商注册信息"
                           + "\n工商注册号：                "     + getNilString(tmp: companyDetail!.reg_on)
                           + "\n法人代表：                    "  + getNilString(tmp: companyDetail!.law_person)
                           + "\n法人代表联系电话：  " + getNilString(tmp: companyDetail!.lp_phone)
                           + "\n注册资本：                    " + getNilString(tmp: companyDetail!.reg_capital)
                           + "\n成立日期：                    " + getNilString(tmp: companyDetail!.found_date)
                           + "\n年报公示状态：             " + getNilString(tmp: companyDetail!.annual_check)
                           + "\n注册地址：                    " + getNilString(tmp: companyDetail!.reg_address)
                           + "\n登记机关：                    " + getNilString(tmp: companyDetail!.reg_branch)
                           + "\n经营期限：                    " + getNilString(tmp: companyDetail!.valid_period)
                           + "\n工商执照扫描件：      " + getNilString(tmp: companyDetail!.reg_certificate)
        // Configure the cell...
        cell.textLabel?.text =  tmp1 + tmp2
        
        // Solution to the exercise
        //cell.imageView?.image = UIImage(named: companys[indexPath.row])
        
        // Uncomment the line below (i.e. removing //) if you just want to display the same image
        // cell.imageView?.image = UIImage(named: "restaurant")
        
        return cell
    }
    
    
    
}
