//
//  ProductDetail.swift
//  kexin
//
//  Created by 维高 on 16/10/22.
//  Copyright © 2016年 维高. All rights reserved.
//

import Foundation
import JSONJoy

struct ProductDetail: JSONJoy {
    let productname: String?
    let brands: String?
    let companyname: String?
    let companyaddress: String?
    let license: String?
    let evaluation: String?
    let iscollect: String?
    let iscomment: String?
    let passtime: Int?
    let productimg:String?
    let webSiteList: WebSiteList?
    let attrList: ProductDetailArrayLists?
    
    
    init(_ decoder: JSONDecoder) throws{
        productname = decoder["productname"].string
        //brands  = decoder["brands"].string
        if decoder["brands"].string != nil{
            brands = decoder["brands"].string
        } else {
            brands = ""
        }
        companyname = decoder["companyname"].string
        companyaddress = decoder["campanyaddress"].string
        //license = decoder["license"].string
        
        if decoder["license"].string != nil{
            license = decoder["license"].string
        } else {
            license = ""
        }
        //evaluation = decoder["evaluation"].string
        if decoder["evaluation"].string != nil{
            evaluation = decoder["evaluation"].string
        } else {
            evaluation = ""
        }
        if decoder["webSiteList"].string != nil {
            webSiteList = try WebSiteList(decoder["webSiteList"])
        }else{
            webSiteList = try WebSiteList()
        }
        //print("\"attrList\":"+decoder["attrList"].description+"}")
        attrList = try ProductDetailArrayLists(JSONDecoder("{\"attrList\":"+"[]"+"}"))
        for tmpJsonDecoder in decoder["attrList"].array!{
            attrList?.productDetailArrayLists.append(ProductDetailArrayList(tmpJsonDecoder))
        }
        iscollect  = decoder["iscollect"].string
        iscomment = decoder["iscomment"].string
        passtime = decoder["passtime"].integer
        
        productimg = decoder["productimg"].description.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
        //webSiteList = try WebSiteList(decoder["webSiteList"])
        
        
        
       
   }
}

public extension JSONDecoder {
    public var stringArray: [String] {
        return ((rawValue as? [String])?.sorted())!
    }
}



struct webSite: JSONJoy {
    let name: String?
    let url: String?
    
    init(_ decoder: JSONDecoder) throws{
        name = decoder["name"].string
        url  = decoder["url"].string
        
    }
    
    init(){
        name  = ""
        url   = ""
    
    }
}

struct WebSiteList: JSONJoy {
    let webSiteList: [webSite]
    init(_ decoder: JSONDecoder) throws{
        guard let coms = decoder["webSiteList"].array
            else {
                throw JSONError.wrongType
                
        }
        
        var collect = [webSite]()
        for addrDecoder in coms {
            collect.append(try webSite(addrDecoder))
        }
        webSiteList = collect
    }
    
    init() throws{
        
        let collect = [webSite]()
        
        webSiteList = collect
    }

}
