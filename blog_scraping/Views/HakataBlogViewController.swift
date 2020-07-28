//
//  HakataBlogViewController.swift
//  blog_scraping
//
//  Created by Yuki Shinohara on 2020/07/14.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class HakataBlogViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    var blogs = [Article]()
    var id = 4021
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "博多校"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData(id: id)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        blogs = [Article]()
    }
    
    func getData(id: Int){
        let url = "https://www.aeonet.co.jp/school/kyushu/fukuoka/\(id)/blog/"
        AF.request(url).responseString { [weak self](response) in
            
            guard let self = self else {return}
            
            if let html = response.value {
                //                print(html)
                if let doc = try? HTML(html: html, encoding: .utf8){
                    var error = [String]()
                    for e in doc.xpath("//h1"){
                        error.append(e.text ?? "")
                    }
                    
                    var titles = [String]()
                    for title in doc.xpath("//h3[@class='p-blog-title']/a"){
                        //                        print(title.text ?? "")
                        titles.append(title.text ?? "")
                    }
                    
                    var dates = [String]()
                    for date in doc.xpath("//p[@class='p-blog-date']"){
                        dates.append(date.text ?? "")
                    }
                    //
                    var blogUrls = [String]()
                    for blogUrl in doc.xpath("//h3[@class='p-blog-title']/a/@href"){
                        //                        print(blogUrl.text ?? "")
                        blogUrls.append(blogUrl.text ?? "")
                    }
                    
                    for (index, value) in titles.enumerated(){
                        var article = Article()
                        article.title = value
                        article.date = dates[index]
                        article.blogURL = blogUrls[index]
                        self.blogs.append(article)
                    }
                    
                    
                    DispatchQueue.main.async {[weak self] in
                        self?.table.reloadData()
                    }
                    
                }
            }
            
        }
    }
    
    
}

extension HakataBlogViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hakataCell", for: indexPath)
        let blog = blogs[indexPath.row]
        cell.textLabel?.text = blog.title
        cell.detailTextLabel?.text = blog.date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(identifier: "BlogDetailVC") as! BlogDetailViewController
        vc.blog = blogs[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
