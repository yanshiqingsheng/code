//
//  CompanyDetail.swift
//  kexin
//
//  Created by 维高 on 16/10/13.
//  Copyright © 2016年 维高. All rights reserved.
//

import Foundation
import JSONJoy

struct CompanyDetail: JSONJoy {
    let address: String?
    let annual_check: String?
    let certificateModels: CertificateModels?
    //let certificateModels: String?
    let collected: Bool?
    let com_name: String?
    let domain: String?
    let found_date: String?
    let have_site: Bool?
    let is_manu_import: String?
    let law_person: String?
    let lp_phone: String?
    let real_business_scope: String?
    let reg_address: String?
    let reg_branch: String?
    let reg_capital: String?
    let reg_certificate: String?
    //let reg_certificate: String?
    let reg_on: String?
    let role_type: String?
    let site_icp_no: String?
    let site_in_charge: String?
    let site_issue_date: String?
    let valid_period: String?
    
  
    
    init(_ decoder: JSONDecoder) throws{
        if decoder["address"].string != nil{
            address = decoder["address"].string
        } else {
            address = ""
        }
        if decoder["annual_check"].string != nil{
          annual_check  = decoder["annual_check"].string
        }else {
                annual_check = ""
            }
        if decoder["certificateModels"].string != nil {
            certificateModels = try CertificateModels(decoder["certificateModels"])
        }else{
            certificateModels = try CertificateModels()
        }
        collected = decoder["collected"].bool
        com_name = decoder["com_name"].string
        domain = decoder["domain"].string
        found_date = decoder["found_date"].string
        have_site = decoder["have_site"].bool
        is_manu_import = decoder["is_manu_import"].string
        law_person = decoder["law_person"].string
        
        lp_phone = decoder["lp_phone"].string
        //if decoder["real_business_scope"].string != nil{
            real_business_scope = decoder["real_business_scope"].string
        //}else{
        //     real_business_scope = ""
        // }
        reg_address = decoder["reg_address"].string
        reg_branch = decoder["reg_branch"].string
        reg_capital = decoder["reg_capital"].string
        reg_certificate = decoder["reg_certificate"].string
        reg_on = decoder["reg_on"].string
        role_type = decoder["role_type"].string
        site_icp_no = decoder["site_icp_no"].string
        site_in_charge = decoder["site_in_charge"].string
        site_issue_date = decoder["site_issue_date"].string
        valid_period = decoder["valid_period"].string
        
    }
}




struct Reg_Certificates: JSONJoy {
    let reg_certificates: [String]
    init(_ decoder: JSONDecoder) throws{
        guard let coms = decoder["reg_certificate"].array
            else {
                throw JSONError.wrongType
                
        }
        
        var collect = [String]()
        for addrDecoder in coms {
            collect.append(String(describing: addrDecoder))
        }
        reg_certificates = collect
    }
}

