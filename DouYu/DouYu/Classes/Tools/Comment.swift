//
//  Comment.swift
//  DouYu
//
//  Created by 李艳楠 on 16/9/18.
//  Copyright © 2016年 Déesse. All rights reserved.
//

import UIKit


let kStatusBarH : CGFloat = 20
let kNavigationBarH : CGFloat = 44

let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height
//MARK: - 通知名称
enum NotificationName: String {
    case TitleViewNotification = "TitleViewNotification" // title click
    case PageContentViewNotification = "PageContentViewNotification" //page scroll
}
