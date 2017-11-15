//
//  PageTitleView.swift
//  Douyu
//
//  Created by xiangliyou on 2017/11/11.
//  Copyright © 2017年 xiangliyou. All rights reserved.
//

import UIKit

//MARK:- 使用协议代理将label事件传递出去  class表示协议只能被类继承
protocol PageTitleViewDelegate : class {
    
    func pageTitleView(PageTitleView : PageTitleView, selectedIndex index : Int)
}

//MARK:- 定义常亮
private let kScrollLineH : CGFloat = 2
//标题的文字颜色
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85,85,85)
private let kSelectedColor : (CGFloat, CGFloat, CGFloat) = (255,128,0)

class PageTitleView: UIView {

    //MARK: -定义属性
    var titles: [String]
    var currentIndex = 0
    //label点击事件的代理，最好用weak
    weak var delegate : PageTitleViewDelegate?
    
    //MARK: -懒加载
    //
    lazy var titleLabels : [UILabel] = [UILabel]()
    //滚动视图
    lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        //禁止显示垂直滚动的线
        scrollView.showsHorizontalScrollIndicator = false
        //滚动到顶部
        scrollView.scrollsToTop = false
        //显示区域不超过内容
        scrollView.bounces = false
        
        return scrollView
    }()
    //滚动线
    lazy var scrollLine : UIView = {
       let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        
        return scrollLine
    }()
    
    // MARK: - 自定义构造函数
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        //设置ui布局
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- 设置ui界面
extension PageTitleView {
    func setupUI() {
        //添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        //添加title对应的label
        setupTitleLabels()
        //设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
    }
    
    //设置title
    private func setupTitleLabels() {
        //确定一些label的值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            //创建label
            let label = UILabel()
            
            //设置属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            //设置frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //将label添加到scrollView
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGs:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupBottomLineAndScrollLine() {
        //添加底线
        let bottom = UIView()
        bottom.backgroundColor = UIColor.lightGray
        
        let lineH : CGFloat = 0.5
        bottom.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        
        //添加滚动条
        scrollView.addSubview(scrollLine)
        //获取第一个label
        guard let firstLabel = titleLabels.first else { return }
        //设置第一个label的颜色为橘色
        firstLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

//MARK:- 监听label的点击
extension PageTitleView {
    @objc func titleLabelClick(tapGs : UITapGestureRecognizer) {
        //获取当label的下标值
        guard let currentlabel = tapGs.view as? UILabel else { return }
        //获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        //切换颜色
        currentlabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        //保存最新的label的下标
        currentIndex = currentlabel.tag
        
        //滚动条的位置发生改变
        let scrollLineX = CGFloat(currentlabel.tag) * scrollLine.frame.width
        //动画时长 s
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //通知代理
        delegate?.pageTitleView(PageTitleView: self, selectedIndex: currentIndex)
        
    }
}

//MARK:- 对外暴露的方法，跟随内容区域滑动改变选中标题
extension PageTitleView {
    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, tatgetIndex : Int) {
        //print("progress=\(progress), sourceIndex=\(sourceIndex), tatgetIndex=\(tatgetIndex)")
        //取出源和目标label
        let sourceLabel = titleLabels[sourceIndex]
        let tatgetLabel = titleLabels[tatgetIndex]
        
        /***处理滑块***/
        let moveTotalX = tatgetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
    
        /**切换文字的颜色  渐变**/
        //1.取出变换的范围
        let colorDelta = (kSelectedColor.0 - kNormalColor.0, kSelectedColor.1 - kNormalColor.1, kSelectedColor.2 - kNormalColor.2)
        //变化源
        sourceLabel.textColor = UIColor(r: kSelectedColor.0 - colorDelta.0 * progress, g: kSelectedColor.1 - colorDelta.1 * progress, b: kSelectedColor.2 - colorDelta.2 * progress)
        //变化目标
        tatgetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        //记录最新的index
        currentIndex = tatgetIndex
    }
}
