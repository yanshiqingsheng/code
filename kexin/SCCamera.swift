//
//  SCCamera.swift
//  kexin
//
//  Created by 刘云飞 on 2017/2/12.
//  Copyright © 2017年 维高. All rights reserved.
//

import Foundation
import UIKit

public class SCCamera{
    
    /**
     当前设备的相机是否可用
     
     :returns: 可用返回true，否则返回false
     */
    public class func isAvailable()->Bool{
        return UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
    }
}
