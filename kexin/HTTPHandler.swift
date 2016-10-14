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


    func getCompanys(keywords:String) -> [Company]
    {
        var companys:[Company] = []
        do {
            //print("city is: \(get_result())")
            var params1 = ["keywords":keywords,"page":"1","pageSize":"10"]
            companys = try Companys(JSONDecoder("{\"companys\":" + get_result(url:"http://114.55.67.233:8080/kexin/enterprise/search", params: params1) + "}")).companys
            
          } catch {
            print("unable to parse the JSON")
        }
        return companys
    }
    
    
    
    func getCompanyDetails(id:String,record_no:String) -> CompanyDetail
    {
        var companys : CompanyDetail?
        do {
            //print("city is: \(get_result())")
            var params1 = ["id":id,"record_no":record_no]
            companys = try CompanyDetail(JSONDecoder( get_result(url:"http://114.55.67.233:8080/kexin/enterprise/detail", params: params1)))
            
        } catch {
            print("unable to parse the JSON")
        }
        return companys!
    }
    
    
    
    
    
    func getProducts() -> [Product]
    {
        var products:[Product] = []
        var params1 = ["productname":"","page":"1","pageSize":"10"]
        do {
            //print("city is: \(get_result())")
            
            products = try Products(JSONDecoder("{\"products\":" + get_result(url:"http://114.55.67.233:8080/kexin/search-product", params: params1) + "}")).products
            
        } catch {
            print("unable to parse the JSON")
        }
        return products
    }


    func get_result(url:String,params:Dictionary<String, String>?)->String
    {
        var result:String? = ""
        
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
