//
//  ReportCompanyDetail.swift
//  kexin
//
//  Created by 维高 on 16/10/26.
//  Copyright © 2016年 维高. All rights reserved.
//

import Foundation
import JSONJoy

struct ReportCompanyDetail: JSONJoy {
    let company_name: String?
    let title: String?
    let description: String?
    let uuid: String?
    let id: String?
    let address:String?
    let fileidlist : FileidLists?
    init(_ decoder: JSONDecoder) throws{
        company_name = decoder["company_name"].string
        title  = decoder["title"].string
        fileidlist = try FileidLists(JSONDecoder("{\"fileidlist\":"+decoder["fileidlist"].description+"}"))
        address = decoder["address"].string
        description = decoder["description"].string
        uuid = decoder["uuid"].string
        id = decoder["id"].string
        
            }
}


struct FileidList: JSONJoy {
    let fileid: String?
    let filetype: String?
   
    init(_ decoder: JSONDecoder) {
        fileid = decoder["fileid"].string
        filetype  = decoder["filetype"].string
        
    }
    
}



struct FileidLists: JSONJoy {
    let products: [FileidList]
    init(_ decoder: JSONDecoder) throws{
        guard let coms = decoder["fileidlist"].array
            else {
                throw JSONError.wrongType
                
        }
        
        var collect = [FileidList]()
        for addrDecoder in coms {
            collect.append(FileidList(addrDecoder))
        }
        products = collect
    }
}

