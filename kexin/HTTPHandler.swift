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


    func getCompanys(_ keywords:String, pageNum :Int) -> [Company]
    {
        var companys:[Company] = []
        do {
            //print("city is: \(get_result())")
            let params1 = ["keywords":keywords,"page":pageNum.description,"pageSize":"10"]
            companys = try Companys(JSONDecoder("{\"companys\":" + get_result("http://114.55.67.233:8080/kexin/enterprise/search", params: params1) + "}")).companys
            
          } catch {
            print("unable to parse the JSON")
        }
        return companys
    }
    
    func getWarnings(_ keywords:String, pageNum :Int) -> [WarningInfo]
    {
        var warnings:[WarningInfo] = []
        do {
            //print("city is: \(get_result())")
            let params1 = ["keywords":keywords,"page":pageNum.description,"pageSize":"10"]
            warnings = try WarningInfos(JSONDecoder("{\"warnings\":" + get_result("http://114.55.67.233:8080/kexin/warings/search", params: params1) + "}")).warnings
            
        } catch {
            print("unable to parse the JSON")
        }
        return warnings
    }
    
    func getCompanyDetails(_ id:String,record_no:String) -> CompanyDetail
    {
        var companys : CompanyDetail?
        do {
            //print("city is: \(get_result())")
            let params1 = ["id":id,"record_no":record_no]
            companys = try CompanyDetail(JSONDecoder( get_result("http://114.55.67.233:8080/kexin/enterprise/detail", params: params1)))
            
        } catch {
            print("unable to parse the JSON")
        }
        return companys!
    }
    
    
    func getReportCompanyDetails(_ id:String) -> ReportCompanyDetail
    {
        var companys : ReportCompanyDetail?
        do {
            //print("city is: \(get_result())")
            //let params1 = ["id":id]
            companys = try ReportCompanyDetail(JSONDecoder( get_result("http://114.55.67.233:8080/kexin/report-company/" + id, params: nil)))
            
        } catch {
            print("unable to parse the JSON")
        }
        return companys!
    }
    
    
    
    func getProductDetails(_ id:String,userid:String) -> ProductDetail
    {
        var productDetail : ProductDetail?
        
        
       
        do {
            
            productDetail = try ProductDetail(JSONDecoder(get_result("http://114.55.67.233:8080/kexin/search-product/"+id+"/"+userid, params: nil).replacingOccurrences(of: "\\n", with: "").replacingOccurrences(of: "\\t", with: "")))
            
        } catch {
            print("unable to parse the JSON")
        }
        return productDetail!
    }
    
    func getReportCompanys() -> [ReportCompany]
    {
        var companys : [ReportCompany] = []
        do {
            //print("city is: \(get_result())")
            //let params1 = ["id":id,"record_no":record_no]
            companys = try ReportCompanys(JSONDecoder( "{\"reportcompanys\":" + get_result("http://114.55.67.233:8080/kexin/report-company", params: nil) + "}")).products
            
        } catch {
            print("unable to parse the JSON")
        }
        return companys
    }

    
    func getProducts(_ keywords:String, pageNum :Int) -> [Product]
    {
        var products:[Product] = []
        let params1 = ["productname":keywords,"page":pageNum.description,"pageSize":"10"]
        do {
            //print("city is: \(get_result())")
            
            products = try Products(JSONDecoder("{\"products\":" + get_result("http://114.55.67.233:8080/kexin/search-product", params: params1) + "}")).products
            
        } catch {
            print("unable to parse the JSON")
        }
        return products
    }


    func get_result(_ url:String,params:Dictionary<String, String>?)->String
    {
        var result:String? = ""
        print(url)
        do {
            
            let opt = try HTTP.GET(url, parameters: params)
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
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

}
