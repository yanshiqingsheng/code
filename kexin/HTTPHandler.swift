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


    func getCompanys(keywords:String, pageNum :Int) -> [Company]
    {
        var companys:[Company] = []
        do {
            //print("city is: \(get_result())")
            let params1 = ["keywords":keywords,"page":pageNum.description,"pageSize":"10"]
            companys = try Companys(JSONDecoder("{\"companys\":" + get_result(url:"http://114.55.67.233:8080/kexin/enterprise/search", params: params1) + "}")).companys
            
          } catch {
            print("unable to parse the JSON")
        }
        return companys
    }
    
    func getWarnings(keywords:String, pageNum :Int) -> [WarningInfo]
    {
        var warnings:[WarningInfo] = []
        do {
            //print("city is: \(get_result())")
            let params1 = ["keywords":keywords,"page":pageNum.description,"pageSize":"10"]
            warnings = try WarningInfos(JSONDecoder("{\"warnings\":" + get_result(url:"http://114.55.67.233:8080/kexin/warings/search", params: params1) + "}")).warnings
            
        } catch {
            print("unable to parse the JSON")
        }
        return warnings
    }
    
    func getCompanyDetails(id:String,record_no:String) -> CompanyDetail
    {
        var companys : CompanyDetail?
        do {
            //print("city is: \(get_result())")
            let params1 = ["id":id,"record_no":record_no]
            companys = try CompanyDetail(JSONDecoder( get_result(url:"http://114.55.67.233:8080/kexin/enterprise/detail", params: params1)))
            
        } catch {
            print("unable to parse the JSON")
        }
        return companys!
    }
    
    func getProductDetails(id:String,userid:String) -> ProductDetail
    {
        var productDetail : ProductDetail?
        
        
        //let test = "{\"productname\":\"注射用盐酸多柔比星\",\"brands\":\"\",\"companyname\":\"深圳万乐药业有限公司\",\"campanyaddress\":\"深圳国家生物医药产业基地坪山新区兰竹东路万乐药业大厦\",\"license\":null,\"evaluation\":\"null\",\"iscollect\":\"0\",\"iscomment\":\"0\",\"passtime\":1357441910000,\"productimg\":[\"http://www.ecdata.org.cn/srv/viewDownloadAction.action?fileName=publishedFile/214894_picurl_.jpg\"],\"authorize\":0,\"webSiteList\":[],\"attrList\":[{\"display_name\":\"用法用量\",\"display_position\":\"OTHER\",\"input_type\":\"TEXT_AREA\",\"extra_info\":\"500\",\"draft_field_name\":\"USAGE\",\"value\":\"静脉冲入、静脉滴注或动脉注射。\\n\"}]}"
        do {
            //print("city is: \(get_result())")
            let params1 = ["id":id,"userid":userid]
            productDetail = try ProductDetail(JSONDecoder(get_result(url:"http://114.55.67.233:8080/kexin/search-product/"+id+"/"+userid, params: nil).replacingOccurrences(of: "\\n", with: "").replacingOccurrences(of: "\\t", with: "")))
            
        } catch {
            print("unable to parse the JSON")
        }
        return productDetail!
    }
    
    
    
    func getProducts(keywords:String, pageNum :Int) -> [Product]
    {
        var products:[Product] = []
        let params1 = ["productname":keywords,"page":pageNum.description,"pageSize":"10"]
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
