//
//  HomeViewController.swift
//  Douyu
//
//  Created by xiangliyou on 2017/11/11.
//  Copyright © 2017年 xiangliyou. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {

    //MARK -懒加载属性
    lazy var pageTitleView : PageTitleView = {
        //64为
       let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationbarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleVIew = PageTitleView(frame: titleFrame, titles: titles)
        
        return titleVIew
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置界面
        setupUI()
    }

}

// MARK -设置UI界面
//使用扩展的方式
extension HomeViewController {
    
    func setupUI() {
        //设置导航栏
        setNavigationBar()
        
        //添加TitleView
        view.addSubview(pageTitleView)
    }
    
    //设置顶上的导航栏
    private func setNavigationBar() {
        //1.左侧的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //2.右侧的item
        let size = CGSize(width: 40, height: 40)

        let historyItem = UIBarButtonItem(imageName: "image_my_history", highimageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highimageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highimageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
    
}
