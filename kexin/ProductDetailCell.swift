//
//  ProductDetailCell.swift
//  kexin
//
//  Created by 维高 on 16/10/22.
//  Copyright © 2016年 维高. All rights reserved.
//

import UIKit

class ProductDetailCell: UITableViewCell {
    
    @IBOutlet var LabelName: UILabel!
    @IBOutlet var LabelValue: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
