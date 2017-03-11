//
//  User.swift
//  kexin
//
//  Created by 刘云飞 on 2017/3/5.
//  Copyright © 2017年 维高. All rights reserved.
//

import Foundation
import JSONJoy

struct User: JSONJoy{
    let token:String?
    let userid:String?
    let username:String?
    
    init(_ decoder: JSONDecoder) {
        token=decoder["token"].string
        userid=decoder["userid"].string
        username=decoder["username"].string
    }
    
    init(_ ttoken: String, tuserid:String, tusername:String) {
        token=ttoken
        userid=tuserid
        username=tusername
    }
}
