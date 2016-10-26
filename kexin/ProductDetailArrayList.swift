//
//  ProductDetailArrayList.swift
//  kexin
//
//  Created by 维高 on 16/10/22.
//  Copyright © 2016年 维高. All rights reserved.
//

import Foundation
import JSONJoy

struct ProductDetailArrayList: JSONJoy {
    let display_name: String?
    let display_position: String?
    let input_type: String?
    let extra_info: String?
    let draft_field_name: String?
    let value: String?
    
    init(_ decoder: JSONDecoder) {
        display_name = decoder["display_name"].string
        display_position  = decoder["display_position"].string
        input_type = decoder["input_type"].string
        //extra_info = decoder["extra_info"].string
        
        if decoder["extra_info"].string != nil{
            extra_info = decoder["extra_info"].string
        } else {
            extra_info = ""
        }
        draft_field_name = decoder["draft_field_name"].string
        print(decoder["value"].string)
        value = decoder["value"].string
        
    }
}

struct ProductDetailArrayLists: JSONJoy {
    let productDetailArrayLists: [ProductDetailArrayList]
    init(_ decoder: JSONDecoder) throws{
        guard let coms = decoder["attrList"].array
            else {
                throw JSONError.wrongType
                
        }
        
        var collect = [ProductDetailArrayList]()
        for addrDecoder in coms {
            collect.append(ProductDetailArrayList(addrDecoder))
        }
        productDetailArrayLists = collect
    }
}
