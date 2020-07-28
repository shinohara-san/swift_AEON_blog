//
//  TenjinBlogViewController.swift
//  blog_scraping
//
//  Created by Yuki Shinohara on 2020/07/11.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//  Refresh https://www.youtube.com/watch?v=8Q5Utz68P8g

import UIKit

class TenjinBlogViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    var blogs = [Article]()
//    var id = 4024
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.refreshControl = UIRefreshControl()
        table.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    @objc func didPullToRefresh(){
         Common.getData(id: TabBarViewController.id, vc: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch TabBarViewController.id {
        case 4024:
            self.navigationItem.title = "天神校"
        case 4021:
            self.navigationItem.title = "博多校"
        default:
            self.navigationItem.title = "姪浜校"
        }
        Common.getData(id: TabBarViewController.id, vc: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        blogs = [Article]()
    }

}



extension TenjinBlogViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let blog = blogs[indexPath.row]
        
        DispatchQueue.main.async {
            cell.textLabel?.text = blog.title
            cell.detailTextLabel?.text = blog.date
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(identifier: "BlogDetailVC") as! BlogDetailViewController
        vc.blog = blogs[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
