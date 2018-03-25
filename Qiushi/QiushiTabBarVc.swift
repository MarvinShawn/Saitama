//
//  QiushiTabBarVc.swift
//  Qiushi
//
//  Created by MarvinX on 2018/3/11.
//  Copyright © 2018年 MarvinX. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import GDPerformanceView_Swift
class QiushiTabBarVc: ASTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVc()

        //打开下面的代码可以看到FPS CPU 内存信息
//        GDPerformanceMonitor.sharedInstance.startMonitoring()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func configureVc() {

        //图标来自http://www.iconfont.cn/collections/detail?spm=a313x.7781069.1998910419.d9df05512&cid=7587
        let options:[[String:Any]] = [
            ["title":"热门","type":ItemType.Hot,"img":"hot"],
            ["title":"最近","type":ItemType.New,"img":"new"],
            ["title":"新图","type":ItemType.HotImage,"img":"img"],
            ["title":"文字","type":ItemType.Text,"img":"text"],
            ["title":"穿越","type":ItemType.Pass,"img":"pass"],
            ["title":"糗图","type":ItemType.QiuTu,"img":"qiutu"],
            ["title":"新鲜","type":ItemType.Fresh,"img":"fresh"],
        ]

        for item in options.shuffle()[1...5] {
            let qiushiVc = QiushiVc.init(titie: item["title"] as! String, type: item["type"] as! ItemType)
            qiushiVc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
            print(qiushiVc)
            let itemImg = item["img"] as! String
            qiushiVc.tabBarItem.image = UIImage.init(named: itemImg + "-normal")
            qiushiVc.tabBarItem.selectedImage = UIImage.init(named: itemImg + "-selected")
            let qiushiNav = UINavigationController.init(rootViewController: qiushiVc)
            self.addChildViewController(qiushiNav)
        }

    }
}
