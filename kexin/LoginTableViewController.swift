//
//  LoginTableViewController.swift
//  kexin
//
//  Created by 维高 on 2017/1/2.
//  Copyright © 2017年 维高. All rights reserved.
//

import UIKit

class LoginTableViewController: UITableViewController {
    
    
    var loginList = ["登录"]
    var funList = ["修改密码"]
    var verList = ["已绑定手机号"]
    var logoutList = ["退出"]
    var lastList = [" "]
    var resultList:[[String]] = []
    let loginHandler = HttpHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultList.insert(loginList, at: 0)
        resultList.insert(funList,at:1)
        resultList.insert(verList,at:2)
        resultList.insert(logoutList,at:3)
        resultList.insert(lastList,at:4)
        
      
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let section :Int = indexPath.section
        let row :Int = indexPath.row
        //LOGIN
        if(section == 0)
        {
            let optionMenu = UIAlertController(title: nil, message: "登录",
                                               preferredStyle: .alert)
            // Add actions to the menu
            
            optionMenu.addTextField {
                (textField: UITextField!) -> Void in
                textField.placeholder = "账号"
            }
            optionMenu.addTextField {
                (textField: UITextField!) -> Void in
                textField.placeholder = "密码"
                textField.isSecureTextEntry = true
            }
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            optionMenu.addAction(cancelAction)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: {(action:UIAlertAction!) -> Void in
                let login:UITextField = (optionMenu.textFields?.first)!
                let password:UITextField = (optionMenu.textFields?.last)!
                //var flag:Bool =  Top10HTTPHandler().getFromLogin(login.text, pw: password.text)
                let flag:Bool =  self.loginHandler.getFromLogin(id:login.text!, pw: password.text!)

                var res = "登录失败"
                if (flag){
                    res = "登录成功"
                    
                    self.tableView.reloadData()
                }
                let logResultMenu = UIAlertController(title: nil, message: res,
                                                      preferredStyle: .alert)
                let cAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                logResultMenu.addAction(cAction)
                // Display the menu
                self.present(logResultMenu, animated: true, completion: nil)
                
                
            })
            optionMenu.addAction(okAction)
            // Display the menu
            self.present(optionMenu, animated: true, completion: nil)
            
        }
        //FEED
        if(section == 1 && row == 0)
        {
            let optionMenu = UIAlertController(title: nil, message: "这么重要的功能竟然还没开发好！",
                                               preferredStyle: .alert)
            // Add actions to the menu
            let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
            optionMenu.addAction(cancelAction)
            // Display the menu
            self.present(optionMenu, animated: true, completion: nil)
            
        }
        //logout
        if(section == 3)
        {
            let optionMenu = UIAlertController(title: nil, message: "退出登录",
                                               preferredStyle: .alert)
            // Add actions to the menu
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            optionMenu.addAction(cancelAction)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: {(action:UIAlertAction!) -> Void in
                self.loginHandler.getLogOutList()
                
                self.tableView.reloadData()
            })
            optionMenu.addAction(okAction)
            // Display the menu
            self.present(optionMenu, animated: true, completion: nil)
            
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.resultList.count
    }
   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        return self.resultList[section].count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        
        var section :Int = indexPath.section
        var row :Int = indexPath.row
        
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = self.resultList[section][row]
        
        if (section == 0)
        {
            var tmp:String = loginHandler.ifLogin()
            if (tmp != ""){
                cell.textLabel?.text = tmp+"已登陆"
            }
            
        }
        if (section == 3)
        {
            cell.textLabel?.textAlignment = .center
            
        }
        
        
        return cell

    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
}
