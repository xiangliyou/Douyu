//
//  UIBarButtonItem-Extension.swift
//  Douyu
//
//  Created by xiangliyou on 2017/11/11.
//  Copyright © 2017年 xiangliyou. All rights reserved.
//
//  扩展首页顶部右边的按钮

import UIKit

extension UIBarButtonItem {
   /* class func createItem(imageName:String, highimageName:String, size: CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highimageName), for: .highlighted)
        
        btn.frame = CGRect(origin: CGPoint(), size: size)
        
        return UIBarButtonItem(customView: btn)
    }
    */
    
    
    //便利构造函数  1> convenience 开头 2>在构造函数中必须明确调用一个设计的构造函数（self）
    public convenience init(imageName:String, highimageName:String = "", size: CGSize = CGSize.zero) {
        //创建button
        let btn = UIButton()
        //设置图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highimageName != "" {
            btn.setImage(UIImage(named: highimageName), for: .highlighted)
        }
        
        //设置尺寸
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint(), size: size)
        }
        
        self.init(customView: btn)
    }
    
}
