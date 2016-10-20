//
//  CertificateModel.swift
//  kexin
//
//  Created by 维高 on 16/10/13.
//  Copyright © 2016年 维高. All rights reserved.
//

import Foundation
import JSONJoy

struct CertificateModel: JSONJoy {
    let certificateImg: String?
    let certificateNo: String?
    let certificate_name: String?
    let issue_branch: Bool?
    let issue_date: String?
    let permit_name: String?
    let range: String?
    let valid_period: String?
    
    init(_ decoder: JSONDecoder) throws{
        certificateImg = decoder["certificateImg"].string
        certificateNo  = decoder["certificateNo"].string
        certificate_name = decoder["certificate_name"].string
        issue_branch = decoder["issue_branch"].bool
        issue_date = decoder["issue_date"].string
        permit_name = decoder["permit_name"].string
        range = decoder["range"].string
        valid_period = decoder["valid_period"].string

        
    }
    
    init() throws{
        certificateImg = ""
        certificateNo  = ""
        certificate_name = ""
        issue_branch = false
        issue_date = ""
        permit_name = ""
        range = ""
        valid_period = ""
        
        
    }
    
}


struct CertificateImgs: JSONJoy {
    let certificateImgs: [String]
    init(_ decoder: JSONDecoder) throws{
        guard let coms = decoder["certificateImg"].array
            else {
                throw JSONError.wrongType
                
        }
        
        var collect = [String]()
        for addrDecoder in coms {
            collect.append(String(describing: addrDecoder))
        }
        certificateImgs = collect
    }
}


struct CertificateModels: JSONJoy {
    let companys: [CertificateModel]
    init(_ decoder: JSONDecoder) throws{
        guard let coms = decoder["certificateModels"].array
            else {
                throw JSONError.wrongType
                
        }
        
        var collect = [CertificateModel]()
        for addrDecoder in coms {
            collect.append(try CertificateModel(addrDecoder))
        }
        companys = collect
    }
    init() throws{
        
        let collect = [CertificateModel]()
        
        companys = collect
    }
}
