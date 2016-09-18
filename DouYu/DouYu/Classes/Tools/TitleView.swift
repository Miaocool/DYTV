//
//  TitleView.swift
//  DouYu
//
//  Created by 李艳楠 on 16/9/18.
//  Copyright © 2016年 Déesse. All rights reserved.
//

import UIKit

class TitleView: UIView {

    fileprivate var titles: [String]
    fileprivate var currentIndex: Int = 0
    fileprivate var titleLabels: [UILabel] = [UILabel]()
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
            label.textColor = UIColor.gray
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
        currentLabel.textColor = UIColor.orange
        if currentLabel.tag != currentIndex {
            oldLabel.textColor = UIColor.gray
        }
        currentIndex = currentLabel.tag
        // 滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine
        .frame.width
        UIView.animate(withDuration: 0.2) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
    }
    
}
