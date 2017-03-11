//
//  ProductTableViewController.swift
//  kexin
//
//  Created by 维高 on 16/10/11.
//  Copyright © 2016年 维高. All rights reserved.
//

import UIKit

class ProductDetailTableViewController : UITableViewController {
    
   
    var id : String?
    var userid : String?
    @IBOutlet var imageView: UIImageView!
    var productDetail : ProductDetail?
    let productDetailHandler = HttpHandler()
    
    var productDetailModules: [ProductDetailModule] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productDetail = HttpHandler.getProductDetails(self.id!, userid: self.userid!)
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.estimatedRowHeight = 80.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        print(productDetail?.productimg?.replacingOccurrences(of: "\"", with: ""))
        print(self.userid)
        self.imageView.kf.setImage(with: URL(string: (productDetail?.productimg?.replacingOccurrences(of: "\"", with: ""))!))
        prepareData()
    }
    
    func prepareData()
    {
    
        var temp = ProductDetailModule()
        temp.labelName = "商品名称"
        temp.labelValue = productDetail?.productname
        productDetailModules.append(temp)
        temp.labelName = "品牌"
        temp.labelValue = productDetail?.brands
        productDetailModules.append(temp)
        temp.labelName = "生产企业"
        temp.labelValue = productDetail?.companyname
        productDetailModules.append(temp)
        temp.labelName = "生产企业地址"
        temp.labelValue = productDetail?.companyaddress
        productDetailModules.append(temp)
        temp.labelName = "生产许可证"
        temp.labelValue = productDetail?.license
        productDetailModules.append(temp)
        temp.labelName = "更新时间"
        temp.labelValue = productDetail?.passtime?.description
        productDetailModules.append(temp)
        temp.labelName = "产品图片"
        temp.labelValue = productDetail?.productimg
        productDetailModules.append(temp)

        for cc in (productDetail?.attrList?.productDetailArrayLists)! {
        
        
            temp.labelName = cc.display_name
            temp.labelValue = cc.value
            productDetailModules.append(temp)
        
        
        
        }
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        switch section {
        // Leave us feedback section
        case 0:
            
            return 1
            
        // Follow us section
        case 1: return productDetailModules.count
            
        case 2: return 1
        default:
            return 1
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //return "ceshi"
        
        switch section {
        // Leave us feedback section
        case 0:
            
             return ""
            
        // Follow us section
        case 1: return "商品信息"
            
        case 2: return "商品评价"
        default:
            return ""
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProductDetailCell
        
        // Configure the cell...
               switch indexPath.section {
        // Leave us feedback section
        case 0:
            
            cell.LabelName?.text = ""
            cell.LabelValue?.text = ""
            
        // Follow us section
        case 1: cell.LabelName?.text = self.productDetailModules[indexPath.row].labelName
        cell.LabelValue?.text = self.productDetailModules[indexPath.row].labelValue

            
        case 2: cell.LabelName?.text = ""
        cell.LabelValue?.text = ""
        default:
            cell.LabelName?.text = ""
            cell.LabelValue?.text = ""        }
        return cell
    }
    
    
    
    
}

