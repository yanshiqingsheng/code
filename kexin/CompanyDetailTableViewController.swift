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
    var id : String?
    var record_no : String?
    var isFavorite : Bool?
    
    @IBOutlet weak var doFavoriteButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        companyDetail = HttpHandler.getCompanyDetails(id!,record_no:record_no!)
        self.tableView.estimatedRowHeight = 10.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        if isFavorite! {
            doFavoriteButton.setTitle("取消收藏", for: .normal)
        }else{
            doFavoriteButton.setTitle("收藏", for: .normal)
        }
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
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reportKnownCompany" {
            let destinationController = segue.destination as! ReportKnownComanyTableViewController
            destinationController.companyId=getNilString(id)
            destinationController.companyName=getNilString(companyDetail?.com_name)
        }
    }*/
    
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
        let tmp1: String = getNilString(companyDetail!.com_name)
                           + "\n\n基本信息"
                           + "\n企业类型：                    " + getNilString(companyDetail!.role_type)
                           + "\n所在地区：                    " + getNilString(companyDetail!.address)
                           + "\n是否有直接进口业务："             + getNilString(companyDetail!.is_manu_import)
        let tmp2: String =   "\n许可范围：                "     + getNilString(companyDetail!.real_business_scope)
                           + "\n是否有门户网站：        "        + getNilString(companyDetail!.have_site?.description)
                           + "\n\n工商注册信息"
                           + "\n工商注册号：                "     + getNilString(companyDetail!.reg_on)
                           + "\n法人代表：                    "  + getNilString(companyDetail!.law_person)
                           + "\n法人代表联系电话：  " + getNilString(companyDetail!.lp_phone)
                           + "\n注册资本：                    " + getNilString(companyDetail!.reg_capital)
                           + "\n成立日期：                    " + getNilString(companyDetail!.found_date)
                           + "\n年报公示状态：             " + getNilString(companyDetail!.annual_check)
                           + "\n注册地址：                    " + getNilString(companyDetail!.reg_address)
                           + "\n登记机关：                    " + getNilString(companyDetail!.reg_branch)
                           + "\n经营期限：                    " + getNilString(companyDetail!.valid_period)
                           + "\n工商执照扫描件：      " + getNilString(companyDetail!.reg_certificate)
        // Configure the cell...
        cell.textLabel?.text =  tmp1 + tmp2
        
        // Solution to the exercise
        //cell.imageView?.image = UIImage(named: companys[indexPath.row])
        
        // Uncomment the line below (i.e. removing //) if you just want to display the same image
        // cell.imageView?.image = UIImage(named: "restaurant")
        
        return cell
    }
    @IBAction func doFavorite(_ sender: Any) {
        if !isFavorite! {
            doFavoriteButton.isEnabled=false
            let favoriteResult=HttpHandler.favoriteCompany(id!)
            if favoriteResult {
                doFavoriteButton.setTitle("取消收藏", for: .normal)
            }else{
            }
            doFavoriteButton.isEnabled=true
        }
    }
    
    
    
}
