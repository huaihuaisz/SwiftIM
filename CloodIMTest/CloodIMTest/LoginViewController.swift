//
//  LoginViewController.swift
//  CloodIMTest
//
//  Created by mac on 16/1/6.
//  Copyright © 2016年 hxrh. All rights reserved.
//

import UIKit

//宽展storyboard  圆角设置
//extension UIView {
//   @IBInspectable var cornerRadius:CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        
//        set {
//            layer.cornerRadius = newValue
//            layer.masksToBounds = (newValue > 0)
//        }
//    }
//}

class LoginViewController: UIViewController, RCAnimatedImagesViewDelegate {

    @IBOutlet weak var loginStackView: UIStackView!
    
    @IBOutlet weak var wallPaperImagesView: RCAnimatedImagesView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.wallPaperImagesView.delegate = self
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.wallPaperImagesView.startAnimating()

        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(1
            ) { () -> Void in
            
            self.loginStackView.axis = UILayoutConstraintAxis.Vertical
            
        }
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.wallPaperImagesView.stopAnimating()

    }
    func animatedImagesNumberOfImages(animatedImagesView: RCAnimatedImagesView!) -> UInt {
        return 3
    }
    
    func animatedImagesView(animatedImagesView: RCAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
        print("image\(index + 1).jpg")
        return UIImage(named: "image\(index + 1).jpg")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
