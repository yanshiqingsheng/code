//
//  ProductCell.swift
//  kexin
//
//  Created by 维高 on 16/10/11.
//  Copyright © 2016年 维高. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet var Label: UILabel!
    @IBOutlet var ImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

   
