//
//  UIColor-Extension.swift
//  Douyu
//
//  Created by xiangliyou on 2017/11/13.
//  Copyright © 2017年 xiangliyou. All rights reserved.
//

import UIKit

//扩展UIColor，实现使用rgb定义颜色,不用除255
extension UIColor {
    
    convenience init(r : CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
