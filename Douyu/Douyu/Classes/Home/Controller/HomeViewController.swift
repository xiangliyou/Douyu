//
//  HomeViewController.swift
//  Douyu
//
//  Created by xiangliyou on 2017/11/11.
//  Copyright © 2017年 xiangliyou. All rights reserved.
//

import UIKit
//当前标题的高度
private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {

    //MARK -懒加载属性
    lazy var pageTitleView : PageTitleView = { [weak self] in
        //64为
       let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationbarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleVIew = PageTitleView(frame: titleFrame, titles: titles)
        //设置标题的代理为实现了PageTitleViewDelegate的HomeViewController本身
        titleVIew.delegate = self
        //titleVIew.backgroundColor = UIColor.blue
        
        return titleVIew
    }()
    //使用弱引用
    lazy var pageContentView : PageContentView = { [weak self] in
        //确定内容frame
        let contentH = kScreenH - kStatusBarH - kNavigationbarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationbarH + kTitleViewH, width: kScreenW, height: contentH)
        //确定所有的字控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            //使用随机的颜色值
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        //设置代理
        contentView.delegate = self
        
        return contentView
    } ()
    
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
        //不需要系统调整scrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //设置导航栏
        setNavigationBar()
        
        //添加TitleView
        view.addSubview(pageTitleView)
        
        
        //添加contenView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
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

//MARK:- 遵守PageTitleViewDelegate协议，实现标题点击事件的监听
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(PageTitleView: PageTitleView, selectedIndex index: Int) {
        //传递给pageContentView处理  联动
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

//MARK:- 遵守PageContentViewDelegate协议，实现内容区域滑动监听
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        //传递给pageTitleView处理  联动
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, tatgetIndex: targetIndex)
    }
}


