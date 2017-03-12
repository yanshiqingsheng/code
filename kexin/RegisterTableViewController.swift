//
//  RegisterTableViewController.swift
//  kexin
//
//  Created by 刘云飞 on 2017/3/12.
//  Copyright © 2017年 维高. All rights reserved.
//

import UIKit

class RegisterTableViewController: UITableViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var fetchCodeButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    @IBAction func registerByPhone(_ sender: Any) {
        if !isPhoneNumber(num: phoneTextField.text!) || codeTextField.text==""
            || passwordTextField.text=="" || usernameTextField.text == ""{
            let alertController = UIAlertController(title: "错误参数",
                                                    message: "请检查您的输入是否正确", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }else {
            registerButton.isEnabled=false
            let registerUser = HttpHandler.getTokenByCode(phoneTextField.text!, code: codeTextField.text!)
            if registerUser.token != "" {
                if HttpHandler.doRegister(username: usernameTextField.text!, pw: passwordTextField.text!, token: registerUser.token!){
                    let alertController = UIAlertController(title: "注册失败",
                                                            message: "注册失败，请联系管理员！", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    let alertController = UIAlertController(title: "注册成功",
                                                            message: "注册成功，请返回登录！", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }
            else{
                registerButton.isEnabled=true
                let alertController = UIAlertController(title: "错误参数",
                                                        message: "验证码不正确，请重新输入", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    @IBOutlet weak var registerButton: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func fetchCode(_ sender: Any) {
        if isPhoneNumber(num: phoneTextField.text!) {
            if HttpHandler.ifRegister(phoneTextField.text!) {
                let alertController = UIAlertController(title: "手机号已注册",
                                                        message: "您使用的手机号已注册，请直接登录", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)

            }else{
                isCounting=true
                if HttpHandler.getCode(phoneTextField.text! , type:1){
                }else{
                    let alertController = UIAlertController(title: "获取验证码失败",
                                                            message: "获取验证码失败，请重新输入手机号码", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            
        }else{
            let alertController = UIAlertController(title: "错误手机号",
                                                    message: "请检查您的手机号是否输入正确", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func isPhoneNumber(num:String)->Bool
    {
        let mobile = "^1\\d{10}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        if ((regextestmobile.evaluate(with: num) == true))
        {
            return true
        }
        else
        {
            return false
        }  
    }
    
    var remainingSeconds: Int = 0 {
        willSet {
            fetchCodeButton.setTitle("\(newValue)秒后重新获取", for: .disabled)
            
            if newValue <= 0 {
                fetchCodeButton.setTitle("重新获取验证码", for: .normal)
                isCounting = false
            }
        }
    }
    
    var countdownTimer: Timer?
    var isCounting = false {
        willSet {
            if newValue {
                fetchCodeButton.isEnabled=false
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime(timer:)), userInfo: nil, repeats: true)
                remainingSeconds = 10
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                fetchCodeButton.isEnabled=true
            }
            
            fetchCodeButton.isEnabled = !newValue
        }
    }
    
    func updateTime(timer: Timer) {
        // 计时开始时，逐秒减少remainingSeconds的值
        remainingSeconds -= 1
    }
    
    

}
