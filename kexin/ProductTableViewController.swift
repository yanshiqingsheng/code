//
//  ProductTableViewController.swift
//  kexin
//
//  Created by 维高 on 16/10/11.
//  Copyright © 2016年 维高. All rights reserved.
//

import UIKit

class ProductTableViewController : UITableViewController {
    
    var products:[Product] = []
    let productHandler = HttpHandler()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        products = productHandler.getProducts()
        self.tableView.estimatedRowHeight = 80.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        //print(companys.count)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProductCell

        
        // Configure the cell...
        cell.Label?.text = "商品名称：" + products[indexPath.row].productname! + "\n生产企业：" + products[indexPath.row].companyname! + "\n商品评价：" + products[indexPath.row].evaluation!
        // Solution to the exercise
        //cell.imageView?.image = UIImage(named: companys[indexPath.row])
        //cell.imageView?.image = UIImage(data: NSData(contentsOfURL:NSURL(string: products[indexPath.row].picurl)!)!)
        //cell.imageView?.sizeThatFits(CGSize(width: 50, height: 50))
        
        
        var strUrl = products[indexPath.row].picurl
        
        //url
        
        var url = NSURL(string: strUrl!)
        
        //图片数据
        
        var data = NSData(contentsOf:url as! URL)
        
        //通过得到图片数据来加载
        cell.ImageView?.image = UIImage(data: data! as Data)
        //cell.imageView?.image?.draw(in: CGRect(x: 0, y: 0, width: 50, height: 50))
        //let image = UIImage(data: data!)
        
        // Uncomment the line below (i.e. removing //) if you just want to display the same image
        // cell.imageView?.image = UIImage(named: "restaurant")
        
        return cell
    }
    
    

    
}
