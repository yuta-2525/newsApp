//
//  ViewController.swift
//  newsAPIApp
//
//  Created by 佐藤勇太 on 2021/12/12.
//

import UIKit
import Lottie

class IntroViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var onboardStringArray = ["世の中には様々なニュースがあります", "毎日、最新の情報を", "選択して", "読んでみよう"]
    
    //ファイル名
    var animationArray = ["0", "1", "2", "3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUPAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setUPAnimation(){
        
        scrollView.contentSize = CGSize(width: view.frame.size.width * 4, height: view.frame.size.height - (self.navigationController?.navigationBar.frame.size.height)!)
        scrollView.isPagingEnabled = true
        
        for i in 0...3 {
            
            let onboardLabel = UILabel(frame: CGRect(x: CGFloat(i * Int(self.view.frame.size.width)), y: self.view.frame.size.height - self.view.frame.size.height/2, width: scrollView.frame.size.width, height: self.view.frame.size.height/2))
            onboardLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
            onboardLabel.textAlignment = .center
            onboardLabel.text = onboardStringArray[i]
            scrollView.addSubview(onboardLabel)
            
            let animationView = AnimationView()
            animationView.contentMode = .scaleAspectFit
            let animation = Animation.named(animationArray[i])
            animationView.frame = CGRect(x: CGFloat(i * Int(self.view.frame.size.width)), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            
            animationView.animation = animation
            animationView.loopMode = .loop
            animationView.play()
            scrollView.addSubview(animationView)
        }
        
    }


}

