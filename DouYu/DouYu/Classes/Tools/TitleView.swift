//
//  TitleView.swift
//  DouYu
//
//  Created by 李艳楠 on 16/9/18.
//  Copyright © 2016年 Déesse. All rights reserved.
//

import UIKit

protocol TitleViewDelegate: class {
    func titleView(titleView: TitleView, selectIndex: Int)
}

fileprivate let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
fileprivate let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
class TitleView: UIView {

    fileprivate var titles: [String]
    fileprivate var currentIndex: Int = 0
    fileprivate var titleLabels: [UILabel] = [UILabel]()
    weak var delegate: TitleViewDelegate?
    fileprivate lazy var scrollView: UIScrollView = {
       let slv = UIScrollView()
        slv.showsVerticalScrollIndicator = false
        slv.scrollsToTop = false
        slv.bounces = false
        
        return slv
    }()
    fileprivate lazy var scrollLine: UIView = {
       let sll = UIView()
        sll.backgroundColor = UIColor.orange
        return sll
    }()
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        setUpUI()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}
//MARK: - 设置UI界面
extension TitleView {
    fileprivate func setUpUI() {
        addSubview(scrollView)
        scrollView.frame = bounds
        setUpLabel()
        setUpBottomLineAndScrollLine()
        
        
    }
    
    private func setUpLabel() {
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - 2
        let labelY : CGFloat = 0
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            scrollView.addSubview(label)
            //设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            titleLabels.append(label)
            // 添加事件
            label.isUserInteractionEnabled = true
            let tapGS = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelCick(tapGes:)))
            label.addGestureRecognizer(tapGS)
        }
    }
    private func setUpBottomLineAndScrollLine() {
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height-lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-2, width: firstLabel.frame.width, height: 2)
    }
    
}
//MARK: - label的点击事件
extension TitleView {
   
    /// label的点击事件
    @objc fileprivate func titleLabelCick(tapGes: UITapGestureRecognizer) {
        
        guard let currentLabel = tapGes.view as? UILabel else { return }
        let oldLabel = titleLabels[currentIndex]
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)

        if currentLabel.tag != currentIndex {
            oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        }
        currentIndex = currentLabel.tag
        // 滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine
        .frame.width
        UIView.animate(withDuration: 0.2) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
        delegate?.titleView(titleView: self, selectIndex: currentIndex)
    }
    
}
//MARK: - 对外暴露方法
extension TitleView {
    
    func setTitleViewWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int)
    {
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 颜色的渐变(复杂)
        // .1.取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        // .2.变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        // .2.变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // .记录最新的index
        currentIndex = targetIndex
    }
}
