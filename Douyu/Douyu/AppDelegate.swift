//
//  AppDelegate.swift
//  Douyu
//
//  Created by xiangliyou on 2017/11/11.
//  Copyright © 2017年 xiangliyou. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //在应用启动时
        //设置UITabBar的颜色
        UITabBar.appearance().tintColor = UIColor.orange
        
        return true
    }

}

