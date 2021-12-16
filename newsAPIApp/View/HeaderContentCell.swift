//
//  HeaderContentCell.swift
//  newsAPIApp
//
//  Created by 佐藤勇太 on 2021/12/15.
//

import UIKit
import SDWebImage

class HeaderContentCell: UITableViewCell {

    @IBOutlet weak var contentsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    
    static let identifier = "HeaderContentCell"
    
    func configure(newsContents:NewsContentsModel){
        
        titleLabel.text = newsContents.title
        authorLabel.text = newsContents.author
        publishedAtLabel.text = newsContents.publishedAt
        contentsImageView.sd_setImage(with: URL(string: newsContents.urlToImage!), completed: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
