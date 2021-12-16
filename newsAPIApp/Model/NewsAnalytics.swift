//
//  NewsAnalytics.swift
//  newsAPIApp
//
//  Created by 佐藤勇太 on 2021/12/12.
//

import Foundation
import Alamofire
import SwiftyJSON
import PKHUD

protocol DoneCatchContentsProtcol{
    
    func doneCatchContents(newsContentsArray:[NewsContentsModel])
}

class NewsAnalytics{
    //JSON解析
    var urlString = String()
    var newsContentArray = [NewsContentsModel]()
    var doneCatchContentsProtcol:DoneCatchContentsProtcol?
    var titleArray = ["", "business", "entertainment", "technology"]
    
    func start(segmentNumber:Int){
        
        HUD.show(.progress)
        
        if segmentNumber == 0{
            urlString = "http://newsapi.org/v2/top-headlines?country=jp&apiKey=22e1161d1d0641dca68fb3c2a2e690ad"
        }else{
            urlString = "http://newsapi.org/v2/top-headlines?country=jp&category=\(titleArray[segmentNumber])&apiKey=22e1161d1d0641dca68fb3c2a2e690ad"
        }
        
       
        
        let encorderUrlString:String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        AF.request(encorderUrlString, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result{
                
            case .success:
                do{
                    let json:JSON = try JSON(data: response.data!)
                    print(json.debugDescription)
                    let totalResults = json["totalResults"].int
                    self.newsContentArray = []
                    
                    for i in 0...totalResults! - 1{
                        print(i)
                        if let author = json["articles"][i]["author"].string,let title = json["articles"][i]["title"].string,let description = json["articles"][i]["description"].string,let url = json["articles"][i]["url"].string,let urlToImage = json["articles"][i]["urlToImage"].string,let publishedAt = json["articles"][i]["publishedAt"].string{
                            
                            let newsContentModel = NewsContentsModel(author: author, title: title, description: description, url: url, urlToImage: urlToImage, publishedAt: publishedAt)
                            
                            self.newsContentArray.append(newsContentModel)
                        }
                    }
                    
                    self.doneCatchContentsProtcol?.doneCatchContents(newsContentsArray: self.newsContentArray)
                    
                    HUD.hide()
                    
                }catch{
                    
                }
                
            case .failure(_):
                print("失敗")
            }
            
            
        }
    }
}

