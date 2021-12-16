//
//  WebViewController.swift
//  newsAPIApp
//
//  Created by 佐藤勇太 on 2021/12/15.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var newsContentModel:NewsContentsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        let request = URLRequest(url: URL(string: (newsContentModel?.url)!)!)
        webView.load(request)
    }

    @IBAction func go(_ sender: Any) {
        webView.goForward()
    }
    
    @IBAction func back(_ sender: Any) {
        webView.goBack()
    }
    
}
