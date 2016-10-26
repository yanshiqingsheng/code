//
//  ReportCompany.swift
//  kexin
//
//  Created by 维高 on 16/10/26.
//  Copyright © 2016年 维高. All rights reserved.
//

import Foundation
import JSONJoy

struct ReportCompany: JSONJoy {
    let title: String?
    let create_time: String?
    let status: String?
    let company_name: String?
    let id: String?
    let address: String?
    init(_ decoder: JSONDecoder) {
        title = decoder["title"].string
        create_time  = decoder["create_time"].string
        status = decoder["status"].string
        company_name = decoder["company_name"].string
        id = decoder["id"].string
        address = decoder["address"].string
        
    }
}

struct ReportCompanys: JSONJoy {
    let products: [ReportCompany]
    init(_ decoder: JSONDecoder) throws{
        guard let coms = decoder["reportcompanys"].array
            else {
                throw JSONError.wrongType
                
        }
        
        var collect = [ReportCompany]()
        for addrDecoder in coms {
            collect.append(ReportCompany(addrDecoder))
        }
        products = collect
    }
}

