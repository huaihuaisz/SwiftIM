//
//  AppDelegate.swift
//  CloodIMTest
//
//  Created by mac on 15/12/29.
//  Copyright © 2015年 hxrh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, RCIMUserInfoDataSource {

    var window: UIWindow?

    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        
        let userInfo = RCUserInfo()
        userInfo.userId = userId
        print("\(userId)");
        switch userId {
            case "shaozhuang":
            userInfo.name = "邵壮"
            userInfo.portraitUri = "http://images.apple.com/cn/macbook-pro/images/overview_hero.jpg"
            
        case "shaozhuang1":
            userInfo.name = "邵壮1"
            userInfo.portraitUri = "http://images.apple.com/cn/macbook-pro/images/overview_hero.jpg"
        default:
            print("无此用户");
        }
        return completion(userInfo)
    }

    func connectServer(completion:()-> Void ) {
        //查询保存的token
        let tokenCache = NSUserDefaults.standardUserDefaults().objectForKey("kDeviceToken") as? String
        
        print("token: \(tokenCache)")
        //初始化appkey
        RCIM.sharedRCIM().initWithAppKey("cpj2xarljgrmn")
        
        RCIM.sharedRCIM().connectWithToken("KbgOv+UYMxY6uqVqjIW1vo/xjMMR1xykhhbJ6BbpVTTJSA9a93PNrkaCDELibXmBOj+W412FUDAaweUVz9S1WuqjKEtMJZCa", success: { (_) -> Void in
            
            let currentUser = RCUserInfo(userId: "shaozhuang1", name: "邵壮1", portrait: nil)
            RCIMClient.sharedRCIMClient().currentUserInfo = currentUser
            
            print("连接成功1")
            //异步执行
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion()
            })
            
            }, error: { (_) -> Void in
                print("连接失败")
            }) { (_) -> Void in
                print("token不正确，或已经失效")
        }


    }
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
                //设置用户信息提供者为自己 appdelegate
        RCIM.sharedRCIM().userInfoDataSource = self
        
                return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

