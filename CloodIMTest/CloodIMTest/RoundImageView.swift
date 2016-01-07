//
//  RoundImageView.swift
//  CloodIMTest
//
//  Created by mac on 16/1/6.
//  Copyright © 2016年 hxrh. All rights reserved.
//

import UIKit

@IBDesignable  // 实时渲染    @IBInspectable是把没有的添加进storyboard   ios8＋ 
class RoundImageView: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    /**
    *  storyboard实时渲染 设置圆角描边等
    */
    //圆角
    @IBInspectable var cornerRadius:CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    //描边
    @IBInspectable var borderWidth:CGFloat = 0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    //描边颜色
    @IBInspectable var borderColor: UIColor? {
        didSet{
            layer.borderColor = borderColor?.CGColor
        }
    }
    
}
