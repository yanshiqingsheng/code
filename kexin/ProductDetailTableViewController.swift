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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productDetail = productDetailHandler.getProductDetails(id: self.id!, userid: self.userid!)
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.estimatedRowHeight = 80.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        print(productDetail?.productimg?.replacingOccurrences(of: "\"", with: ""))
        print(self.userid)
        self.imageView.kf.setImage(with: URL(string: (productDetail?.productimg?.replacingOccurrences(of: "\"", with: ""))!))
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 3
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "ceshi"
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProductDetailCell
        
        // Configure the cell...
        cell.LabelName?.text = "2"
        cell.LabelValue?.text = "2"
        // Solution to the exercise
        //cell.imageView?.image = UIImage(named: companys[indexPath.row])
        //cell.imageView?.image = UIImage(data: NSData(contentsOfURL:NSURL(string: products[indexPath.row].picurl)!)!)
        //cell.imageView?.sizeThatFits(CGSize(width: 50, height: 50))
        
        
        //var strUrl = products[indexPath.row].picurl
        
        //url
        
        //var url = NSURL(string: strUrl!)
        
        //图片数据
        
        //var data = NSData(contentsOf:url as! URL)
        
        //通过得到图片数据来加载
        //cell.ImageView?.image = UIImage(data: data! as Data)
        //cell.imageView?.image?.draw(in: CGRect(x: 0, y: 0, width: 50, height: 50))
        //let image = UIImage(data: data!)
        
        // Uncomment the line below (i.e. removing //) if you just want to display the same image
        // cell.imageView?.image = UIImage(named: "restaurant")
        
        return cell
    }
    
    
    
    
}

