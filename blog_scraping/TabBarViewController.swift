//
//  TabBarViewController.swift
//  blog_scraping
//
//  Created by Yuki Shinohara on 2020/07/14.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    static var id = 4024
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            TabBarViewController.id = 4024
        case 1:
            TabBarViewController.id = 4021
        default:
            TabBarViewController.id = 4026
        }
    }
}
