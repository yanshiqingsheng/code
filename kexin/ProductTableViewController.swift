//
//  ProductTableViewController.swift
//  kexin
//
//  Created by 维高 on 16/10/11.
//  Copyright © 2016年 维高. All rights reserved.
//

import UIKit
import Kingfisher


class ProductTableViewController : UITableViewController , UISearchResultsUpdating{
    
    var products:[Product] = []
    let productHandler = HttpHandler()
    var searchProducts:[Product] = []

    
    var searchController: UISearchController!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        products = productHandler.getProducts(keywords: "")
        self.tableView.estimatedRowHeight = 80.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
 
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "查找商品..."
        //print(companys.count)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        //return products.count
        
        if searchController.isActive {
            return searchProducts.count
        } else {
            return products.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProductCell

        let pro = (searchController.isActive) ? searchProducts[indexPath.row] : products[indexPath.row]
        
        // Configure the cell...
        cell.Label?.text = "商品名称：" + pro.productname! + "\n生产企业：" + pro.companyname! + "\n商品评价：" + pro.evaluation!
        // Solution to the exercise
        //cell.imageView?.image = UIImage(named: companys[indexPath.row])
        //cell.imageView?.image = UIImage(data: NSData(contentsOfURL:NSURL(string: products[indexPath.row].picurl)!)!)
        //cell.imageView?.sizeThatFits(CGSize(width: 50, height: 50))
        
        
        let strUrl = pro.picurl
        
        //url
        
        //var url = NSURL(string: strUrl!)
        let url = URL(string: strUrl!)
        //图片数据
        
        //var data = NSData(contentsOf:url as! URL)
        
        //通过得到图片数据来加载
        //cell.ImageView?.image = UIImage(data: data! as Data)
        
        cell.ImageView?.kf.setImage(with: url)
        
                //cell.imageView?.image?.draw(in: CGRect(x: 0, y: 0, width: 50, height: 50))
        //let image = UIImage(data: data!)
        
        // Uncomment the line below (i.e. removing //) if you just want to display the same image
        // cell.imageView?.image = UIImage(named: "restaurant")
        
        return cell
    }
    
    func filterContent(for searchText: String) {
        searchProducts = productHandler.getProducts(keywords: searchText)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            
            tableView.reloadData()
        }
    }

    
}
