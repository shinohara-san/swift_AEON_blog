//
//  Common.swift
//  blog_scraping
//
//  Created by Yuki Shinohara on 2020/07/14.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import Foundation
import Alamofire
import Kanna

class Common {
    class func getData(id: Int, vc: TenjinBlogViewController){
        vc.blogs.removeAll()
        
        if vc.table.refreshControl?.isRefreshing == true{
            print("refreshing data")
        } else {
            print("fetching data")
        }
        
        let url = "https://www.aeonet.co.jp/school/kyushu/fukuoka/\(id)/blog/"
        AF.request(url).responseString { (response) in
            
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
                        vc.blogs.append(article)
                    }
                    
                    DispatchQueue.main.async {
                        vc.table.refreshControl?.endRefreshing()
                        vc.table.reloadData()
                    }
                }
            }
        }
    }
}
