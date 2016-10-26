//
//  WarningInfo.swift
//  kexin
//
//  Created by 维高 on 16/10/23.
//  Copyright © 2016年 维高. All rights reserved.
//

import Foundation
import JSONJoy

struct WarningInfo: JSONJoy {
    let title: String?
    let enterprise: String?
    let eid: String?
    let product: String?
    let pid: String?
    let content: String?
    let publish_department: String?
    let publish_time: String?
    init(_ decoder: JSONDecoder) {
        title = decoder["title"].string
        enterprise  = decoder["enterprise"].string
        eid = decoder["eid"].string
        product = decoder["product"].string
        pid = decoder["pid"].string
        content = decoder["content"].string
        publish_department = decoder["publish_department"].string
        publish_time  = decoder["publish_time"].string
    }
}

struct WarningInfos: JSONJoy {
    let warnings: [WarningInfo]
    init(_ decoder: JSONDecoder) throws{
        guard let coms = decoder["warnings"].array
            else {
                throw JSONError.wrongType
                
        }
        
        var collect = [WarningInfo]()
        for addrDecoder in coms {
            collect.append(WarningInfo(addrDecoder))
        }
        warnings = collect
    }
}

