//
//  HTTPResponse.swift
//  kexin
//
//  Created by 刘云飞 on 2017/3/5.
//  Copyright © 2017年 维高. All rights reserved.
//

import Foundation
import JSONJoy

struct HTTPResponse :JSONJoy{
    let code:String?
    let message:String?
    
    init(_ decoder: JSONDecoder) {
        code=decoder["code"].string
        message=decoder["message"].string
    }
}
