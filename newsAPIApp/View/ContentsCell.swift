//
//  ContentsCell.swift
//  newsAPIApp
//
//  Created by 佐藤勇太 on 2021/12/15.
//

import UIKit
import SDWebImage

class ContentsCell: UITableViewCell {

    @IBOutlet weak var contentsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    
    static var identifier = "ContensCell"
    
    func configure(newsContents:NewsContentsModel){
        
        titleLabel.text = newsContents.title
        authorLabel.text = newsContents.author
        publishedAtLabel.text = newsContents.publishedAt
        contentsImageView.sd_setImage(with: URL(string: newsContents.urlToImage!), completed: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentsImageView.layer.cornerRadius = contentsImageView.frame.width/2
        contentsImageView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
