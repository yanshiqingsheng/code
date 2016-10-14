//
//  Company.swift
//  kexin
//
//  Created by 维高 on 16/10/9.
//  Copyright © 2016年 维高. All rights reserved.
//

import Foundation
import JSONJoy

struct Company: JSONJoy {
    let record_no: String?
    let com_name: String?
    let role_type: String?
    let reg_address: String?
    let product_num: String?
    let eid: String?
   
    init(_ decoder: JSONDecoder) {
         record_no = decoder["record_no"].string
         com_name  = decoder["com_name"].string
         role_type = decoder["role_type"].string
         reg_address = decoder["reg_address"].string
         product_num = decoder["product_num"].string
         eid = decoder["eid"].string
     
    }
}

struct Companys: JSONJoy {
    let companys: [Company]
    init(_ decoder: JSONDecoder) throws{
        guard let coms = decoder["companys"].array
            else {
                throw JSONError.wrongType
                
            }
        
        var collect = [Company]()
        for addrDecoder in coms {
            collect.append(Company(addrDecoder))
        }
        companys = collect
    }
}
