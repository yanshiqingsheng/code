//
//  ReportCompanyDetailController.swift
//  kexin
//
//  Created by 维高 on 16/10/26.
//  Copyright © 2016年 维高. All rights reserved.
//

import UIKit
import AVFoundation
class ReportCompanyDetailController : UITableViewController {
    
    
    var id : String?
    //var userid : String?

    var reportCompanyDetail : ReportCompanyDetail?
    let reportCompanyHandler = HttpHandler()
    var audioPlayer:AVAudioPlayer!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportCompanyDetail = reportCompanyHandler.getReportCompanyDetails(id: self.id!)
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.estimatedRowHeight = 80.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        //self.imageView.kf.setImage(with: URL(string: (productDetail?.productimg?.replacingOccurrences(of: "\"", with: ""))!))
        //prepareData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        switch section {
        // Leave us feedback section
        case 0:
            
            return 4
            
        // Follow us section
        case 1: return 3
        default:
            return 1
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //return "ceshi"
        
        switch section {
        // Leave us feedback section
        case 0:
            
            return ""
            
        // Follow us section
        case 1: return "  "
            
       
        default:
            return ""
        }
        
    }
    /*
    @IBAction func startPlaying(sender: AnyObject) {
        
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: URL(string: "blob:http://114.55.67.233:8080/6cfef343-3d34-4bf5-b5f4-91026cabd4a6")!)
                audioPlayer.play()
                print("play!!")
            } catch {
            }
        
    }*/
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cellIdentifier2 = "Cell2"
        var cell : UITableViewCell?
        
        
        // Configure the cell...
        switch indexPath.section {
        // Leave us feedback section
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

            switch indexPath.row
            {   case 0 : cell?.textLabel?.text? = "企业名称           " + (self.reportCompanyDetail?.company_name)!
                case 1 : cell?.textLabel?.text = "标        题           " + (self.reportCompanyDetail?.title)!
                case 2 : cell?.textLabel?.text = "描        述           " + (self.reportCompanyDetail?.description)!
                case 3 : cell?.textLabel?.text = "我的位置           " + (self.reportCompanyDetail?.address)!
                default: break
            }
        // Follow us section
        case 1:
                let cell2 = tableView.dequeueReusableCell(withIdentifier: cellIdentifier2, for: indexPath) as! ReportCompanyDetailWebCell
               // let url = URL(string: "http://www.appcoda.com/contact")
               // let request = URLRequest(url: url!)
                //cell?.contentView.
                cell2.labelName.text = "视频"
                
                return cell2
        default: break
                }
        return cell!
    }
    
    
    
    
}

