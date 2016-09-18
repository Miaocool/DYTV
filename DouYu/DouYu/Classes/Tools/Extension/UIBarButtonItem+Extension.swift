//
//  UIBarButtonItem+Extension.swift
//  DouYu
//
//  Created by 李艳楠 on 16/9/18.
//  Copyright © 2016年 Déesse. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    
    convenience init(image: UIImage, highImage: UIImage? = UIImage(), size : CGSize = CGSize.zero)  {
        // 1.创建UIButton
        let btn = UIButton()
        
        // 2.设置btn的图片
        btn.setImage(image, for: .normal)
        if highImage != nil {
            btn.setImage(highImage, for: .highlighted)
        }
        // 3.设置btn的尺寸
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        // 4.创建UIBarButtonItem
        self.init(customView : btn)
    }
    
    convenience init(imageName : String, highImageName : String = "", size : CGSize = CGSize.zero)  {
        // 1.创建UIButton
        let btn = UIButton()
        
        // 2.设置btn的图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        // 3.设置btn的尺寸
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        // 4.创建UIBarButtonItem
        self.init(customView : btn)
    }

}
