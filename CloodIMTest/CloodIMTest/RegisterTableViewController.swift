//
//  RegisterTableViewController.swift
//  CloodIMTest
//
//  Created by mac on 16/1/7.
//  Copyright © 2016年 hxrh. All rights reserved.
//

import UIKit

class RegisterTableViewController: UITableViewController {

    @IBOutlet weak var userName: UITextBox!
    @IBOutlet weak var password: UITextBox!
    @IBOutlet weak var email: UITextBox!
    @IBOutlet weak var region: UITextBox!
    @IBOutlet weak var question: UITextBox!
    @IBOutlet weak var answer: UITextBox!
    
    var possibleInputs : Inputs = []
    
    
    //检查必填
    func checkRequeriedField() {
        self.view.runBlockOnAllSubviews { (subview) -> Void in
            if let subview = subview as? UITextField{
                if subview.text!.isEmpty {
                        self.errorNotice("必选项为空", autoClear: true)
                }
            }
        }
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        guard predicate.evaluateWithObject(email.text) else {
            self.errorNotice("email 格式不正确")
            return
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "注册"
        self.navigationController?.navigationBarHidden = false
        
        let doneItem = UIBarButtonItem(title: "完成", style: .Done, target: self, action: "doneClick:")
        
        self.navigationItem.rightBarButtonItem = doneItem
        
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        let v1 = AJWValidator(type: .String)
        v1.addValidationToEnsureMinimumLength(3, invalidMessage: "用户名至少3位")
        v1.addValidationToEnsureMaximumLength(15, invalidMessage: "最大15位")
        self.userName.ajw_attachValidator(v1)
        v1.validatorStateChangedHandler = { (newState:AJWValidatorState) ->Void in
            switch newState{
                case .ValidationStateValid:
                    self.userName.highlightState = UITextBoxHighlightState.Default
                    self.possibleInputs.unionInPlace(Inputs.user)

                default:
                    let errMessage = v1.errorMessages.first as? String
                    self.userName.highlightState = UITextBoxHighlightState.Wrong(errMessage!)
                    self.possibleInputs.subtractInPlace(Inputs.user)
            }
            doneItem.enabled = self.possibleInputs.boolValue
        }
        
        let v2 = AJWValidator(type: .String)
        v2.addValidationToEnsureMinimumLength(6, invalidMessage: "密码至少6位")
        v2.addValidationToEnsureMaximumLength(15, invalidMessage: "最大15位")
        self.password.ajw_attachValidator(v2)
        v2.validatorStateChangedHandler = { (newState: AJWValidatorState) -> Void in
            switch newState{
            case .ValidationStateValid:
                self.password.highlightState = UITextBoxHighlightState.Default
                self.possibleInputs.unionInPlace(Inputs.pass)
            default:
                let errMessage = v2.errorMessages.first as? String
                self.password.highlightState = UITextBoxHighlightState.Wrong(errMessage!)
                self.possibleInputs.subtractInPlace(Inputs.pass)
            }
            doneItem.enabled = self.possibleInputs.boolValue
        }
        
        let v3 = AJWValidator(type: .String)
        v3.addValidationToEnsureValidEmailWithInvalidMessage("Email格式不对")
        self.email.ajw_attachValidator(v3)
        
        v3.validatorStateChangedHandler = { (newState: AJWValidatorState) -> Void in
            switch newState{
            case .ValidationStateValid:
                self.email.highlightState = UITextBoxHighlightState.Default
                self.possibleInputs.unionInPlace(Inputs.mail)
            default:
                let errMessage = v3.errorMessages.first as? String
                self.email.highlightState = UITextBoxHighlightState.Wrong(errMessage!)
                self.possibleInputs.subtractInPlace(Inputs.mail)
            }
            doneItem.enabled = self.possibleInputs.boolValue
        }
    }

    func doneClick(sender: UIBarButtonItem) {
//        checkRequeriedField()
        userName.resignFirstResponder()
        password.resignFirstResponder()
        //显示一个载入提示
        self.pleaseWait()
        
        //建立用户的 AVObject
        let user = AVObject(className: "SZUser")
        
        //把输入都文本框的值，设置到对象中
        user["user"] = self.userName.text
        user["pass"] = self.password.text
        user["mail"] = self.email.text
        user["area"] = self.region.text
        user["ques"] = self.question.text
        user["answ"] = self.answer.text
        
        //查询用户是否已经注册
        let query = AVQuery(className: "SZUser")
        query.whereKey("user", equalTo: self.userName.text)
        
        //执行查询
        query.getFirstObjectInBackgroundWithBlock { (object, err) -> Void in
          self.clearAllNotice()
            if object != nil {
            //用户已注册
                self.errorNotice("已经注册")
                self.userName.becomeFirstResponder()
            } else {
                //注册
                user.saveInBackgroundWithBlock({ (successed, err) -> Void in
                    if successed {
                        self.successNotice("注册成功")
                        self.navigationController?.popViewControllerAnimated(true)
                    } else {
                        self.errorNotice(err.localizedDescription)
                    }
                })
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
