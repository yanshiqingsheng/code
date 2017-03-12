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
    var pageNum: Int = 1
    var showFavorite: Bool = false

    
    @IBOutlet var productTableView: UITableView!
    @IBOutlet weak var favoriteButton: UIButton!
    var searchController: UISearchController!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        products = HttpHandler.getProducts("", pageNum: pageNum,showFavorite: showFavorite)
        self.tableView.estimatedRowHeight = 80.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
 
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "请输入关键字"
        //print(companys.count)
        self.setupRefresh()
    }
    
    
    func setupRefresh(){
        self.tableView.addHeaderWithCallback({
            let tempproducts = HttpHandler.getProducts("", pageNum: self.pageNum, showFavorite: self.showFavorite)
            if(tempproducts.count != 0)
            {
                self.products = tempproducts
            }
            
            let delayInSeconds:Int64 =  100000000  * 2
            
            
            let popTime:DispatchTime = DispatchTime.now() + Double(delayInSeconds) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: popTime, execute: {
                self.tableView.reloadData()
                self.tableView.headerEndRefreshing()
            })
            
        })
        
        
        self.tableView.addFooterWithCallback({
            
            self.pageNum = self.pageNum + 1
            let tempproducts = HttpHandler.getProducts("", pageNum: self.pageNum, showFavorite: self.showFavorite)
            if(tempproducts.count != 0)
            {
                self.products.append(contentsOf: tempproducts)
            }
            let delayInSeconds:Int64 = 100000000 * 2
            let popTime:DispatchTime = DispatchTime.now() + Double(delayInSeconds) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: popTime, execute: {
                self.tableView.reloadData()
                self.tableView.footerEndRefreshing()
                
                //self.tableView.setFooterHidden(true)
            })
        })
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
        let strUrl = pro.picurl
        
       
        let url = URL(string: strUrl!)
        cell.ImageView?.kf.setImage(with: url)
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProductDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! ProductDetailTableViewController
                
                let com = (searchController.isActive) ? searchProducts[indexPath.row] : products[indexPath.row]
                destinationController.id  =  com.id
                destinationController.userid =  com.id
            }
        }
    }
    
    
    
    func filterContent(for searchText: String) {
        searchProducts = HttpHandler.getProducts(searchText, pageNum: 1, showFavorite: showFavorite)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            
            tableView.reloadData()
        }
    }

    @IBAction func showFavorite(_ sender: Any) {
        if HttpHandler.ifLogin() {
            if showFavorite {
                showFavorite=false
                favoriteButton.isEnabled=false
                self.viewDidLoad()
                productTableView.reloadData()
                favoriteButton.setTitle("收藏的商品", for: .normal)
                favoriteButton.isEnabled=true
            }else{
                showFavorite=true
                favoriteButton.isEnabled=false
                self.viewDidLoad()
                productTableView.reloadData()
                favoriteButton.setTitle("全部商品", for: .normal)
                favoriteButton.isEnabled=true
            }
            
        }else{
            let alertController = UIAlertController(title: "登录提示",
                                                    message: "请登录后重试", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }

    }
    
}
