//
//  TopViewController.swift
//  newsAPIApp
//
//  Created by 佐藤勇太 on 2021/12/12.
//

import UIKit

class TopViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, DoneCatchContentsProtcol {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var newsContentsArray = [NewsContentsModel]()
    let newsAnalytics = NewsAnalytics()
    
    
    enum CellType{
        
        case top
        case notTop
    }
    
    let cellType:[CellType] = [.top,.notTop]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        newsAnalytics.doneCatchContentsProtcol = self
        
        tableView.register(UINib(nibName: "HeaderContentCell", bundle: nil), forCellReuseIdentifier: HeaderContentCell.identifier)
        tableView.register(UINib(nibName: "ContentsCell", bundle: nil), forCellReuseIdentifier: ContentsCell.identifier)
    }

    
    func setIndex(){
        if UserDefaults.standard.object(forKey: "indexNumber") != nil{
            let indexNumber = UserDefaults.standard.object(forKey: "indexNumber") as! Int
            check(segmentNumber: indexNumber)
            segment.selectedSegmentIndex = indexNumber
        }else{
            check(segmentNumber: 0)
            segment.selectedSegmentIndex = 0
        }
    }
    
    func check(segmentNumber:Int){
        
        newsAnalytics.start(segmentNumber: segmentNumber)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        setIndex()
    }
    
    func doneCatchContents(newsContentsArray: [NewsContentsModel]) {
        self.newsContentsArray = []
        self.newsContentsArray = newsContentsArray
        tableView.reloadData()
        
    }

    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsContentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellType:CellType
        if indexPath.row < 1{
            cellType = .top
        }else{
            cellType = .notTop
        }
        
        switch cellType{
            
        case .top:
            let headerContentCell = tableView.dequeueReusableCell(withIdentifier: HeaderContentCell.identifier, for: indexPath) as! HeaderContentCell
            return headerContentCell
            
            headerContentCell.configure(newsContents: newsContentsArray[indexPath.row])
            
        case .notTop:
            let contentsCell = tableView.dequeueReusableCell(withIdentifier: ContentsCell.identifier, for: indexPath) as! ContentsCell
            contentsCell.configure(newsContents: newsContentsArray[indexPath.row])
            
            return contentsCell
            
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 1{
            return 300
        }else{
            return 116
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = self.storyboard?.instantiateViewController(withIdentifier: "webVC") as! WebViewController
        webVC.newsContentModel = newsContentsArray[indexPath.row]
        
        UserDefaults.standard.set(segment.selectedSegmentIndex, forKey: "indexNumber")
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    @IBAction func selectSegment(_ sender: UISegmentedControl) {
        
        UserDefaults.standard.set(segment.selectedSegmentIndex, forKey: "indexNumber")
        
        setIndex()
        check(segmentNumber: sender.selectedSegmentIndex)
        tableView.setContentOffset(.zero, animated: true)
    }
    

}
