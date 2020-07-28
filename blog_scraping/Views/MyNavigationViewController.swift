//
//  MyNavigationViewController.swift
//  blog_scraping
//
//  Created by Yuki Shinohara on 2020/07/28.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import UIKit

class MyNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = UIColor(red: 0/255, green: 147/255, blue: 231/255, alpha: 1.0)
        // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
        navigationBar.tintColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 1.0)
        // ナビゲーションバーのテキストを変更する
        navigationBar.titleTextAttributes = [
            // 文字の色
            .foregroundColor: UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 1.0)
        ]
    }


}
