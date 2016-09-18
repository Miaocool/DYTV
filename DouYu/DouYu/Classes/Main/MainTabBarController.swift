//
//  MainTabBarController.swift
//  DouYu
//
//  Created by 李艳楠 on 16/9/18.
//  Copyright © 2016年 Déesse. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC(vcString: "Home")
        addChildVC(vcString: "Seeding")
        addChildVC(vcString: "Follow")
        addChildVC(vcString: "Profile")
   
    }
    
}
//MARK: -辅助方法
extension MainTabBarController {
    /// 添加子控制器
    fileprivate func addChildVC(vcString: String) {
        guard let vc = UIStoryboard(name: vcString, bundle: nil).instantiateInitialViewController() else {return}
        addChildViewController(vc)
       }
}
