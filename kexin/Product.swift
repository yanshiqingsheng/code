//
//  Product.swift
//  kexin
//
//  Created by 维高 on 16/10/11.
//  Copyright © 2016年 维高. All rights reserved.
//

import Foundation
import JSONJoy

struct Product: JSONJoy {
    let companyname: String?
    let evaluation: String?
    let id: String?
    let picurl: String?
    let productname: String?
    init(_ decoder: JSONDecoder) {
        companyname = decoder["companyname"].string
        evaluation  = decoder["evaluation"].string
        id = decoder["id"].string
        picurl = decoder["picurl"].string
        productname = decoder["productname"].string
        
        
    }
}

struct Products: JSONJoy {
    let products: [Product]
    init(_ decoder: JSONDecoder) throws{
        guard let coms = decoder["products"].array
            else {
                throw JSONError.wrongType
                
        }
        
        var collect = [Product]()
        for addrDecoder in coms {
            collect.append(Product(addrDecoder))
        }
        products = collect
    }
}
