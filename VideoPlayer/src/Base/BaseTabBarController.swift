//
//  BaseTabBarController.swift
//  VideoPlayer
//
//  Created by admin on 2018/1/13.
//  Copyright © 2018年 虞嘉伟. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let mainNavi = BaseNavigationController(rootViewController: MainViewController())
        let downNavi = BaseNavigationController(rootViewController: DownloadViewController())
        
        mainNavi.title = "视频"
        mainNavi.tabBarItem.image = UIImage(named: "IconRes/icon_home_nor.png")
        mainNavi.tabBarItem.selectedImage = UIImage(named: "IconRes/icon_home_sel.png")
        
        downNavi.title = "下载"
        downNavi.tabBarItem.image = UIImage(named: "IconRes/icon_down_nor.png")
        downNavi.tabBarItem.selectedImage = UIImage(named: "IconRes/icon_down_sel.png")
        
        self.viewControllers = [mainNavi, downNavi]
    }
}
