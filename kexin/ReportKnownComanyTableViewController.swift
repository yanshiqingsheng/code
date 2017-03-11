//
//  ReportKnownComanyTableViewController.swift
//  kexin
//
//  Created by 刘云飞 on 2017/2/12.
//  Copyright © 2017年 维高. All rights reserved.
//

import UIKit
import MobileCoreServices

class ReportKnownComanyTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var pictureButton: UIButton!
    @IBOutlet weak var comanyNameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var voiceButton: UIButton!
    @IBOutlet weak var movieButton: UIButton!
    var companyId : String?
    var companyName : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.comanyNameTextField.text=self.companyName

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addPicture(_ sender: Any) {
        if SCCamera.isAvailable(){
            
            //根据指定的SourceType来获取该SourceType下可以用的媒体类型，返回的是一个数组
            let mediaTypeArr:NSArray = UIImagePickerController.availableMediaTypes(for: UIImagePickerControllerSourceType.camera)! as NSArray
            
            //判断数组中是否存在kUTTypeMovie和kUTTypeImage类型（需要import MobileCoreServices）
            //kUTTypeMovie 表示可以录制带有音频的视频
            //kUTTypeImage 表示可以拍摄照片
            if mediaTypeArr.contains(kUTTypeMovie) && mediaTypeArr.contains(kUTTypeImage){
                
                //创建一个UIImagePickerController
                var pickerControl = UIImagePickerController()
                //必须，第一步，设置SourceType，Camera表示相机
                pickerControl.sourceType = UIImagePickerControllerSourceType.camera
                //必须，第二步，设置相机的View中可以使用的媒体类型，这里直接使用上面的mediaTypeArr,它包含了视频和图像
                pickerControl.mediaTypes = mediaTypeArr as [AnyObject] as [AnyObject] as! [String]
                //必须，第三步，设置delegate：UIImagePickerControllerDelegate,UINavigationControllerDelegate
                //这两个必须都写上，可以进入头文件查看到
                pickerControl.delegate = self
                
                //可选，视频最长的录制时间，这里是10秒，默认为10分钟（600秒）
                pickerControl.videoMaximumDuration = 10
                //可选，设置视频的质量，默认就是TypeMedium
                pickerControl.videoQuality = UIImagePickerControllerQualityType.typeMedium
                //设置视频或者图片拍摄好后，是否能编辑，默认为false不能编辑
                pickerControl.allowsEditing = true
                
                //必须，第四步，显示
                self.present(pickerControl, animated: true, completion: nil)
            }
        }else{
//            SCMessageBox.show(self, title: "提示", contentMsg: "当前设备不支持摄像头", buttonString: "确认", blockHandler: nil)
        }
    }
    
    //拍摄完成（用户点击了Done按钮）
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        ///info是一个字典，包含了拍摄结果的各种信息
        let infodic:NSDictionary = info as NSDictionary
        
        //获取键值UIImagePickerControllerMediaType的值，表示了当前处理的是视频还是图片
        let mediaType = infodic["UIImagePickerControllerMediaType"] as! String
        
        //如果是视频的话
        if mediaType == kUTTypeMovie as String{
            saveMovie(infodic: infodic)
        }
            //如果是图片
        else if mediaType == kUTTypeImage as String{
            savePicture(infodic: infodic)
        }
        //最后，dismiss拍摄窗口
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    //保存视频方法
    func saveMovie(infodic:NSDictionary){
        //系统保存到tmp目录里的视频文件的路径
        let mediaUrl: NSURL = infodic[UIImagePickerControllerMediaURL] as! NSURL
        let videoPath = mediaUrl.path
        
        //如果视频文件可以保存的话
        if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(videoPath!){
            //用这个方法来保存视频
            UISaveVideoAtPathToSavedPhotosAlbum(videoPath!, nil, nil, nil)
        }
    }
    //保存图片方法
    func savePicture(infodic:NSDictionary){
        
        //拍摄的原始图片
        let originalImage:UIImage?
        //用户修改后的图片（如果allowsEditing设置为True，那么用户可以编辑）
        let editedImage:UIImage?
        //最终要保存的图片
        let savedImage:UIImage?
        
        //从字典中获取键值UIImagePickerControllerEditedImage的值，它直接包含了图片数据
        editedImage = infodic["UIImagePickerControllerEditedImage"] as? UIImage
        //从字典中获取键值UIImagePickerControllerOriginalImage的值，它直接包含了图片数据
        originalImage = infodic["UIImagePickerControllerOriginalImage"] as? UIImage
        
        upload(data: UIImagePNGRepresentation(originalImage!)!)
        /*
        //判断是否有编辑图片，如果有就使用编辑的图片
        if (editedImage != nil){
            savedImage = editedImage
        }else{
            savedImage = originalImage
        }
        
        //保存图片到用户的相机胶卷中
        UIImageWriteToSavedPhotosAlbum(savedImage!, nil, nil, nil)*/
    }
    
    func upload(data:Data)
    {
        
//        lb.frame=CGRectMake(0,0, self.view.bounds.size.width,20)
//        
//        lb.textColor=UIColor.whiteColor()
//        lb.text="上传中...."
//        lb.textAlignment=NSTextAlignment.Center
//        lb.backgroundColor=UIColor.blackColor()
//        lb.alpha=1
//        
//        //添加风火轮
//        av.frame=CGRectMake(200,200,20, 20)
//        av.backgroundColor=UIColor.whiteColor()
//        av.color=UIColor.redColor()
//        av.startAnimating()
//        
//        self.view.addSubview(av)
//        
//        self.view.addSubview(lb)
        
//        let data=UIImagePNGRepresentation(img)//把图片转成data
        
        let uploadurl:String="http://android.ecdata.org.cn:9080/uploadfile"//设置服务器接收地址
        //分界标识
        let boundaryID="haha"
        //上传文件的方法
            if uploadurl.isEmpty{
                print ("主地址不能为空")
                return
            }
            /*/固定拼接的第一部分
            let top=NSMutableString()
            top.append("--haha\r\n")
            top.append("Content-Disposition: form-data; name=\"file\"; filename=\"name\"\r\n")
            top.append("Content-Type: Content-Type:image/png\r\n\r\n")
            //固定拼接第三部分
            let buttom=NSMutableString()
            buttom.append("--haha\r\n")
            buttom.append("Content-Disposition: form-data; name=\"file\"\r\n\r\n")
            buttom.append("Submit\r\n")
            buttom.append("--haha--\r\n")
            //拼接
            let fromData=NSMutableData()
            fromData.append(top.data(using: String.Encoding.utf8.rawValue)!)
            fromData.append(data)
            fromData.append(buttom.data(using: String.Encoding.utf8.rawValue)!)
            //可变请求
            let requset=NSMutableURLRequest(url: NSURL(string: uploadurl)! as URL)
            requset.httpBody=fromData as Data
            requset.httpMethod="POST"
            requset.addValue(String(fromData.length), forHTTPHeaderField:"Content-Length")
            let contype=String(format: "multipart/form-data; boundary=haha", boundaryID)
            requset.setValue(contype, forHTTPHeaderField: "Content-Type")*/
        let request=NSMutableURLRequest(url:NSURL(string:uploadurl)! as URL)
        request.httpMethod="POST"//设置请求方式
        let boundary:String="----WebKitFormBoundaryUqe19UcZdnsXAPV9"
        let contentType:String="multipart/form-data; boundary="+boundary
        request.addValue(contentType, forHTTPHeaderField:"Content-Type")
        let body=NSMutableData()
        //在表单中插入要上传的数据
        //        body.append(NSString(format: "--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!);
        //        body.append(NSString(format: "Content-Disposition:form-data;name=\"userid\"\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
        //        body.append("\("123")\r\n".data(using: String.Encoding.utf8)!)
        //在表单中写入要上传的图片
        body.append(NSString(format:"--\(boundary)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format:"Content-Disposition: form-data; name=\"file\"; filename=\"WechatIMG1.png\"\r\n").data(using: String.Encoding.utf8.rawValue)!)
        
        //body.appendData(NSString(format:"Content-Type:application/octet-stream\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.append("Content-Type:image/png\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(data)
        body.append(NSString(format:"\r\n--\(boundary)--\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        //设置post的请求体
        request.httpBody=body as Data

            let session=URLSession.shared
            session.uploadTask(with: request as URLRequest, from: nil) { (responseData, response, error) -> Void in
                if error==nil{
                    print(String(data: responseData!, encoding: String.Encoding.utf8))
                }
                else{
                    print(responseData)
                    let picureId:String=String(data: responseData!, encoding: String.Encoding.utf8)!
                    print(picureId)
                }
            }.resume()
        
    }


    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
