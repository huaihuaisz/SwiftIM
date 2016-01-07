//
//  ConversationViewController.swift
//  CloodIMTest
//
//  Created by mac on 15/12/30.
//  Copyright © 2015年 hxrh. All rights reserved.
//

import UIKit

class ConversationViewController: RCConversationViewController {

    override func viewDidLoad() {
        super.viewDidLoad() 

//        self.targetId = "shaozhuang1"
//        self.conversationType = .ConversationType_PRIVATE
//        self.title = "与邵对话中";

        //头像样式
        self.setMessageAvatarStyle(.USER_AVATAR_RECTANGLE)
        
        //如果是单聊，不显示发送方昵称
        if (self.conversationType == .ConversationType_PRIVATE) {
            self.displayUserNameInCell = false;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    

}
