//
//  HTTPHandler.swift
//  kexin
//
//  Created by 维高 on 16/10/9.
//  Copyright © 2016年 维高. All rights reserved.
//

import Foundation
import SwiftHTTP
import JSONJoy

class HttpHandler {
    static var serviceAddress:String="http://android.ecdata.org.cn:9080"
    static var loginUser:User?=User(JSONDecoder(""))
    
    static var testUser:User?=User("38ACA304DEC308C382AE5AD8DA6BFF25",tuserid: "13661830924",tusername: "liuyunfei")
    
    
    
    static func getLoginUser()  -> User
    {
        return loginUser!
//        return testUser!
    }
    
    //判断是否注册过
    static func ifRegister(_ phone:String) -> Bool {
        let md5=generateKeyByPhone(phone)
        let responseJson = JSONDecoder(get_result("\(serviceAddress)/userout/get-user-by-phone/\(phone)/\(md5)",params:nil))
        let aaa=responseJson["phone"].string
        if aaa != nil {
            return true
        }
        return false;
    }
    
    //发送验证码, type为1表示注册，2表示修改或找回
    static func getCode(_ phone:String, type : Int) -> Bool {
        let md5=generateKeyByPhone(phone)
        let responseJson:JSONDecoder=JSONDecoder(get_result("\(serviceAddress)/userout/get-validate-code/\(phone)/\(type)/\(md5)",params:nil))
        let aaa=responseJson["code"].string
        if aaa != nil {
            return false
        }
        return true;
    }
    
    //判断验证码是否正确
    static func getTokenByCode(_ phone:String , code:String) -> User {
        let responseJson = JSONDecoder(get_result("\(serviceAddress)/userout/checkout-code/\(phone)/\(code)",params:nil))
        let aaa=responseJson["userid"].string
        if aaa != nil {
            let result : User = User(responseJson["token"].string!, tuserid: aaa!,  tusername: "")
            return result
        }
        return User("",tuserid: "",tusername: "");
    }
    
    static func logout()
    {
        loginUser=User(JSONDecoder(""));
    }
    
    static func ifLogin() -> Bool {
        if getLoginUser().token==nil {
            return false;
        }
        return true
    }
    
    static func getFromLogin(id:String, pw: String)->Bool{
        let result = false
        let postRes=post_result("\(serviceAddress)/userout/login", params: "phone=\(id)&password=\(pw)")
        if postRes==""
        {
            return result
        }
        do {
            loginUser=try User(JSONDecoder(postRes))
            if loginUser?.userid==nil {
                return false
            }
            return true;
        }catch {
            return false
        }
        return result
    }
    
    static func modifyPassword(token:String, pw: String)->Bool{
        let result = false
        let postRes=post_result("\(serviceAddress)/userout/modify-password", params: "password=\(pw)&token=\(token)")
        if postRes == "success" {
            return true
        }
        return result
    }
    
    static func doRegister(username:String, pw: String, token: String)->Bool{
        let result = false
        let postRes=post_result("\(serviceAddress)/userout", params: "username=\(username)&password=\(pw)&token=\(token)")
        if postRes == ""
        {
            return result
        }
        if postRes == "success" {
            return true
        }
        return result
    }
    
    static func getCompanys(_ keywords:String, pageNum :Int, showFavorite:Bool) -> [Company]
    {
        var companys:[Company] = []
        do {
            if showFavorite{
                let tmpUserId:String=getLoginUser().userid!
                let params1 = ["keywords":keywords,"page":pageNum.description,"pageSize":"10","userid":tmpUserId]
                companys = try Companys(JSONDecoder("{\"companys\":" + get_result("\(serviceAddress)/enterprise/collected", params: params1) + "}")).companys
            }else{
                let params1 = ["keywords":keywords,"page":pageNum.description,"pageSize":"10"]
                companys = try Companys(JSONDecoder("{\"companys\":" + get_result("\(serviceAddress)/enterprise/search", params: params1) + "}")).companys
            }
            
        } catch {
            print("unable to parse the JSON")
        }
        return companys
    }
    
    static func getWarnings(_ keywords:String, pageNum :Int) -> [WarningInfo]
    {
        var warnings:[WarningInfo] = []
        do {
            //print("city is: \(get_result())")
            let params1 = ["keywords":keywords,"page":pageNum.description,"pageSize":"10"]
            warnings = try WarningInfos(JSONDecoder("{\"warnings\":" + get_result("\(serviceAddress)/warings/search", params: params1) + "}")).warnings
            
        } catch {
            print("unable to parse the JSON")
        }
        return warnings
    }
    
    static func favoriteCompany(_ companyId:String) -> Bool{
        let tmpUserId:String=getLoginUser().userid!
        let postRes=post_result("\(serviceAddress)/collect-company"+"?companyid=\(companyId)&userid=\(tmpUserId)",params: "")
        if postRes != "" {
            return true
        }
        return false
    }
    
    static func cancelFavoriteCompany(_ companyId:String) -> Bool{
        let tmpUserId:String=getLoginUser().userid!
        let postRes=delete_result("\(serviceAddress)/collect-company"+"?companyid=\(companyId)&userid=\(tmpUserId)",params: "")
        if postRes != "" {
            return true
        }
        return false
    }
    
    static func getCompanyDetails(_ id:String,record_no:String) -> CompanyDetail
    {
        var companys : CompanyDetail?
        do {
            //print("city is: \(get_result())")
            let params1 = ["id":id,"record_no":record_no]
            companys = try CompanyDetail(JSONDecoder( get_result("\(serviceAddress)/enterprise/detail", params: params1)))
            
        } catch {
            print("unable to parse the JSON")
        }
        return companys!
    }
    
    
    static func getReportCompanyDetails(_ id:String) -> ReportCompanyDetail
    {
        var companys : ReportCompanyDetail?
        do {
            //print("city is: \(get_result())")
            //let params1 = ["id":id]
            companys = try ReportCompanyDetail(JSONDecoder( get_result("\(serviceAddress)/report-company/" + id, params: nil)))
            
        } catch {
            print("unable to parse the JSON")
        }
        return companys!
    }
    
    
    
    static func getProductDetails(_ id:String,userid:String) -> ProductDetail
    {
        var productDetail : ProductDetail?
        
        
        
        do {
            
            productDetail = try ProductDetail(JSONDecoder(get_result("\(serviceAddress)/search-product/"+id+"/"+userid, params: nil).replacingOccurrences(of: "\\n", with: "").replacingOccurrences(of: "\\t", with: "")))
            
        } catch {
            print("unable to parse the JSON")
        }
        return productDetail!
    }
    
    static func getReportCompanys() -> [ReportCompany]
    {
        var companys : [ReportCompany] = []
        do {
            //print("city is: \(get_result())")
            //let params1 = ["id":id,"record_no":record_no]
            companys = try ReportCompanys(JSONDecoder( "{\"reportcompanys\":" + get_result("\(serviceAddress)/report-company", params: nil) + "}")).products
            
        } catch {
            print("unable to parse the JSON")
        }
        return companys
    }
    
    
    static func getProducts(_ keywords:String, pageNum :Int, showFavorite:Bool) -> [Product]
    {
        var products:[Product] = []
        
        do {
            //print("city is: \(get_result())")
            if showFavorite{
                let tmpUserId:String=getLoginUser().userid!
                let params1 = ["productname":keywords,"page":pageNum.description,"pageSize":"10","userid":tmpUserId]
                products = try Products(JSONDecoder("{\"products\":" + get_result("\(serviceAddress)/search-collect-product", params: params1) + "}")).products
            }else {
                let params1 = ["productname":keywords,"page":pageNum.description,"pageSize":"10"]
                products = try Products(JSONDecoder("{\"products\":" + get_result("\(serviceAddress)/search-product", params: params1) + "}")).products
            }
            
        } catch {
            print("unable to parse the JSON")
        }
        return products
    }
    
    static func favoriteProduct(_ productid:String) -> Bool{
        let tmpUserId:String=getLoginUser().userid!
        let postRes=post_result("\(serviceAddress)/collect-product"+"?productid=\(productid)&userid=\(tmpUserId)",params: "")
        if postRes != "" {
            return true
        }
        return false
    }
    
    static func cancelFavoriteProduct(_ productid:String) -> Bool{
        let tmpUserId:String=getLoginUser().userid!
        let postRes=delete_result("\(serviceAddress)/collect-product"+"?productid=\(productid)&userid=\(tmpUserId)",params: "")
        if postRes != "" {
            return true
        }
        return false
    }
    
    static func getFile(_ fileId:String) -> Data {
        var result:Data?
        let url="\(serviceAddress)/doDownload/"+fileId
        do {
            let opt = try HTTP.GET(url)
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                result = response.data
                print("opt finished: \(response.text)")
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        while result == nil {
            sleep(1)
            //return result!
        }
        return result!;
    }
    
    static func sessionSimpleDownload(){
        //下载地址
        let url = URL(string: "http://android.ecdata.org.cn:9080/doDownload/7f000001-59ba-18ff-815a-3a4b323d0055")
        //请求
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared
        //下载任务
        let downloadTask = session.downloadTask(with: request,
                                                completionHandler: { (location:URL?, response:URLResponse?, error:Error?)
                                                    -> Void in
                                                    //输出下载文件原来的存放目录
                                                    print("location:\(location)")
                                                    //location位置转换
                                                    let locationPath = location!.path
                                                    //拷贝到用户目录
                                                    let documnets:String = NSHomeDirectory() + "/Documents/1.mp4"
                                                    //创建文件管理器
                                                    let fileManager = FileManager.default
                                                    try! fileManager.moveItem(atPath: locationPath, toPath: documnets)
                                                    print("new location:\(documnets)")
        })
        
        //使用resume方法启动任务
        downloadTask.resume()
    }
    
    
    static func get_result(_ url:String,params:Dictionary<String, String>?)->String
    {
        var result:String? = ""
        print(url)
        do {
            
            let opt = try HTTP.GET(url, parameters: params)
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    result = NSString(data: response.data, encoding: String.Encoding.utf8.rawValue) as String?
                    //                    return //also notify app of failure as needed
                }
                result = response.text
                print("opt finished: \(response.text)")
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
        while result == "" {
            sleep(1)
            //return result!
        }
        //sleep(2)
        return result!
        
    }
    
    static func delete_result(_ url:String,params:String)->String
    {
        //        var path = "http://android.ecdata.org.cn:9080/userout/login"
        //        var headparams:NSMutableDictionary = NSMutableDictionary()
        //        headparams["X-xxxx-App-Token"] = "xxxxxx-xxx-xxxx-xxxx-xxxxxxxxxx"
        // 1. URL
        var nsurl:NSURL = NSURL(string: url)!
        
        // 2. 请求(可以改的请求)
        var request:NSMutableURLRequest = NSMutableURLRequest(url: nsurl as URL)
        request.httpMethod = "DELETE"
        let boundary:String="-------------------21212222222222222222222"
        request.httpBody = params.data(using: String.Encoding.utf8, allowLossyConversion: false)! as Data
        request.setValue("xxxxxx-xxx-xxxx-xxxx-xxxxxxxxxx", forHTTPHeaderField:"X-xxxx-App-Token")
        /*NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue:OperationQueue()) { (res, data, error)in
         
         let  str = NSString(data: data!, encoding:String.Encoding.utf8.rawValue)
         print(str)
         
         }*/
        var response:URLResponse?
        do {
            try NSURLConnection.sendSynchronousRequest(request as URLRequest,returning:&response) as NSData?
            return "success"
        }catch {
        }
        return ""

    }

    
    static func post_result(_ url:String, params:String) -> String {
        //        var path = "http://android.ecdata.org.cn:9080/userout/login"
//        var headparams:NSMutableDictionary = NSMutableDictionary()
//        headparams["X-xxxx-App-Token"] = "xxxxxx-xxx-xxxx-xxxx-xxxxxxxxxx"
        // 1. URL
        var nsurl:NSURL = NSURL(string: url)!
        
        // 2. 请求(可以改的请求)
        var request:NSMutableURLRequest = NSMutableURLRequest(url: nsurl as URL)
        request.httpMethod = "POST"
        let boundary:String="-------------------21212222222222222222222"
        request.httpBody = params.data(using: String.Encoding.utf8, allowLossyConversion: false)! as Data
        request.setValue("xxxxxx-xxx-xxxx-xxxx-xxxxxxxxxx", forHTTPHeaderField:"X-xxxx-App-Token")
        /*NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue:OperationQueue()) { (res, data, error)in
         
         let  str = NSString(data: data!, encoding:String.Encoding.utf8.rawValue)
         print(str)
         
         }*/
        var response:URLResponse?
        do {
            var data = try NSURLConnection.sendSynchronousRequest(request as URLRequest,returning:&response) as NSData?
            return String(data: data as! Data, encoding:String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        }catch {}
        return ""
    }
    
    static func generateKeyByPhone(_ phone:String) -> String {
        let result=phone+"kexin2016"
        return result.md5().uppercased()
    }
    
}
