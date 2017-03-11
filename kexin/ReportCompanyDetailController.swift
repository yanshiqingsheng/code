//
//  ReportCompanyDetailController.swift
//  kexin
//
//  Created by 维高 on 16/10/26.
//  Copyright © 2016年 维高. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
class ReportCompanyDetailController : UITableViewController {
    
    
    var id : String?
    //var userid : String?

    var reportCompanyDetail : ReportCompanyDetail?
    let reportCompanyHandler = HttpHandler()
    var audioPlayer:AVAudioPlayer!
    var pictureIds:[String]=[]
    var videoIds:[String]=[]
    var auidoIds:[String]=[]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportCompanyDetail = HttpHandler.getReportCompanyDetails(self.id!)
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.estimatedRowHeight = 80.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        if (reportCompanyDetail != nil) && ((reportCompanyDetail?.fileidlist) != nil)  {
            for fileId in (reportCompanyDetail?.fileidlist?.products)!{
                if fileId.filetype=="1"{
                    pictureIds.append(fileId.fileid!)
                }else if fileId.filetype=="2"{
                    videoIds.append(fileId.fileid!)
                }else{
                    auidoIds.append(fileId.fileid!)
                }
            }
        }
        
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
        case 0: return 4//企业信息
        case 1: return pictureIds.count//图片
        case 2: return videoIds.count//视频
        case 3: return auidoIds.count//音频
        default:
            return 1
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
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
    
    @IBAction func startPlaying(_ sender: AnyObject) {
        
            do {
                let url = URL(string: "blob:http://android.ecdata.org.cn:9080/a1b8e418-31d3-48d6-9566-c59e166472b6")
                let audioData:Data = try Data(contentsOf : url!)
                try audioPlayer = AVAudioPlayer(data: audioData as Data)
                audioPlayer.play()
                print("play!!")
            } catch {
            }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let infoCellId = "infoCell"
        let videoCellId = "videoCell"
        let pictureCellId = "pictureCell"
        let audioCellId = "audioCell"
        var infoCell : UITableViewCell?
        var pictureCell : UITableViewCell?
        var videoCell : UITableViewCell?
        var audioCell : UITableViewCell?
        
        
        // Configure the cell...
        switch indexPath.section {
        // Leave us feedback section
        case 0:
            infoCell = tableView.dequeueReusableCell(withIdentifier: infoCellId, for: indexPath)
            
            switch indexPath.row
            {   case 0 : infoCell?.textLabel?.text? = "企业名称           " + (self.reportCompanyDetail?.company_name)!
                case 1 : infoCell?.textLabel?.text = "标        题           " + (self.reportCompanyDetail?.title)!
                case 2 : infoCell?.textLabel?.text = "描        述           " + (self.reportCompanyDetail?.description)!
                case 3 :
                    if ((self.reportCompanyDetail?.address) != nil){
                        infoCell?.textLabel?.text = "我的位置           " + (self.reportCompanyDetail?.address)!
                    }
                    else{
                        infoCell?.textLabel?.text = "我的位置           "
                    }
                default: break
            }
        // Follow us section
        case 1:
            let cell2 = tableView.dequeueReusableCell(withIdentifier: pictureCellId, for: indexPath) as! ReportCompanyDetailWebCell
            cell2.labelName.text = "照片证据"
            return cell2
        case 2:
            let cell3 = tableView.dequeueReusableCell(withIdentifier: videoCellId, for: indexPath) as! ReportCompanyDetailWebCell
            cell3.labelName.text = "视频证据"
            return cell3
        case 3:
            let cell4 = tableView.dequeueReusableCell(withIdentifier: audioCellId, for: indexPath) as! ReportCompanyDetailWebCell
            cell4.labelName.text = "音频证据"
            return cell4
        default: break
        }
        return infoCell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "companyVideoDetail" {
//            if let indexPath = tableView.indexPathForSelectedRow {
                let destination = segue.destination as! AVPlayerViewController
                let url = URL(string:
                    "http://android.ecdata.org.cn:9080/doDownload/7f000001-59ba-18ff-815a-3a4b323d0055")
//            let data:Data=reportCompanyHandler.getFile("7f000001-59ba-18ff-815a-3a4b323d0055")
//                let fileid=videoIds[indexPath.row]
//                let playerItem = AVPlayerItem(url: url!)
//            
//                NotificationCenter.default.addObserver(self, selector: Selector("myMovieFinishedCallback:"), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
            destination.player = AVPlayer(url:url!)
//            }
        }
    }
    
    
    
    
}

