//
//  ConversationListViewController.swift
//  CloodIMTest
//
//  Created by mac on 16/1/4.
//  Copyright © 2016年 hxrh. All rights reserved.
//

import UIKit

class ConversationListViewController: RCConversationListViewController
{

    @IBAction func showMenu(sender: UIBarButtonItem) {
//        var frame = sender.valueForKey("view")?.frame
//        frame?.origin.y = (frame?.origin.y)! + 30
//        KxMenu.showMenuInView(self.view, fromRect: frame!, menuItems:[KxMenuItem("客服", image:UIImage(named: "Icon_tabbar_1@2x"), target:self, action:"ClickMenu1"), KxMenuItem("好友邵壮", image:UIImage(named: "Icon_tabbar_2@2x"), target:self, action:"ClickMenu2")])
        
        let items = [MenuItem(title: "客服", iconName: "Icon_tabbar_1", glowColor: UIColor.redColor(), index: 0), MenuItem(title: "好友邵壮", iconName: "Icon_tabbar_2", glowColor: UIColor.blueColor(), index: 1), MenuItem(title: "通讯录", iconName: "Icon_tabbar_3", glowColor: UIColor.yellowColor(), index: 2), MenuItem(title: "关于", iconName: "Icon_tabbar_3", glowColor: UIColor.grayColor(), index: 3)]
        
        let menu = PopMenu(frame: self.view.bounds, items: items)
        menu.menuAnimationType = .NetEase
        
        if menu.isShowed {
            return
        }
        
        menu.didSelectedItemCompletion = { (selectedItem: MenuItem!)-> Void in
            switch selectedItem.index {
            case 1:
                let conVC = RCConversationViewController()
                conVC.targetId = "shaozhuang"
                conVC.userName = "邵壮"
                conVC.conversationType = RCConversationType.ConversationType_PRIVATE
                conVC.title = "与邵壮聊天中"
                self.navigationController?.pushViewController(conVC, animated: true)
                self.tabBarController?.tabBar.hidden = true
                
            default:
                print(selectedItem.title)
            }
        }
        
        menu.showMenuAtView(self.view)
    }
   
    func ClickMenu1() {
        print("点击1")
    }
    
    func ClickMenu2() {
       
        let conVC = RCConversationViewController()
                conVC.targetId = "shaozhuang"
                conVC.userName = "邵壮"
                conVC.conversationType = RCConversationType.ConversationType_PRIVATE
                conVC.title = "与邵壮聊天中"
                self.navigationController?.pushViewController(conVC, animated: true)
                self.tabBarController?.tabBar.hidden = true
    }
    
    let conVC = RCConversationViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        appDelegate?.connectServer({ () -> Void in
            self.setDisplayConversationTypes([RCConversationType.ConversationType_APPSERVICE.rawValue, RCConversationType.ConversationType_CHATROOM.rawValue, RCConversationType.ConversationType_CUSTOMERSERVICE.rawValue, RCConversationType.ConversationType_DISCUSSION.rawValue, RCConversationType.ConversationType_GROUP.rawValue, RCConversationType.ConversationType_PRIVATE.rawValue, RCConversationType.ConversationType_PUBLICSERVICE.rawValue, RCConversationType.ConversationType_PUSHSERVICE.rawValue, RCConversationType.ConversationType_SYSTEM.rawValue
                ])
            self.refreshConversationTableViewIfNeeded()
        })
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let destVC = segue.destinationViewController as? RCConversationViewController
        destVC?.targetId = self.conVC.targetId
        destVC?.userName = self.conVC.userName
        destVC?.conversationType = self.conVC.conversationType
        destVC?.title = conVC.title
        
        self.tabBarController?.tabBar.hidden = true
    }

    override func onSelectedTableRow(conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, atIndexPath indexPath: NSIndexPath!) {
//
//        let conVC = RCConversationViewController()
//        
//        conVC.targetId = model.targetId
//        conVC.userName = model.conversationTitle
//        conVC.conversationType = RCConversationType.ConversationType_PRIVATE
//        conVC.title = model.conversationTitle
//        
//        self.navigationController?.pushViewController(conVC, animated: true)
//        self.tabBarController?.tabBar.hidden = true
    
     
        conVC.targetId = model.targetId
        conVC.userName = model.conversationTitle
        conVC.conversationType = RCConversationType.ConversationType_PRIVATE
        conVC.title = model.conversationTitle
        
        self.performSegueWithIdentifier("tapOnCell", sender: self)
    }

}
