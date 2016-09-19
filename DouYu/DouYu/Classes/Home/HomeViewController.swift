//
//  HomeViewController.swift
//  DouYu
//
//  Created by 李艳楠 on 16/9/18.
//  Copyright © 2016年 Déesse. All rights reserved.
//

import UIKit
private let kTitleViewH : CGFloat = 40
class HomeViewController: UIViewController {

    fileprivate lazy var titleView: TitleView = {
        let tvFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let tv = TitleView(frame: tvFrame, titles: ["推荐", "游戏", "娱乐", "趣玩"])
        tv.delegate = self
        return tv
    }()
    fileprivate lazy var pageContentView: PageContentView = {[weak self] in
        // 1.确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        // 2.确定所有的子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        setUpUI()
    }
}
//MARK: - UI界面
extension HomeViewController {
    
    fileprivate func setUpUI() {
        // 0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        // 1.设置导航栏
        setupNavigationBar()
        
        // 2.添加TitleView
        view.addSubview(titleView)
        
        // 3.添加ContentView
        view.addSubview(pageContentView)
    }
    private func setupNavigationBar() {
        // 1.设置左侧的Item
//        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        // 2.设置右侧的Item
        let size = CGSize(width: 40, height: 40)
//        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let historyItem = UIBarButtonItem(image: #imageLiteral(resourceName: "image_my_history"), highImage: #imageLiteral(resourceName: "Image_my_history_click"), size: size)
//        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let searchItem = UIBarButtonItem(image: #imageLiteral(resourceName: "btn_search"), highImage: #imageLiteral(resourceName: "btn_search_clicked"), size: size)
        
//        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        let qrcodeItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Image_scan"), highImage: #imageLiteral(resourceName: "Image_scan_click"), size: size)
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}
//MARK: - TitleViewDelegate
extension HomeViewController: TitleViewDelegate{
    
    func titleView(titleView: TitleView, selectIndex: Int) {
        pageContentView.setCurrentIndex(currentIndex: selectIndex)
    }
}
//MARK: - PageContentView
extension HomeViewController: PageContentViewDelegate{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        titleView.setTitleViewWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

