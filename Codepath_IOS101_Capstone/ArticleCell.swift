//
//  NewsCell.swift
//  Codepath_IOS101_Capstone
//
//  Created by mary ramirez on 11/15/25.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var ArticleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        ArticleImageView.layer.cornerRadius = 10
        ArticleImageView.clipsToBounds = true
        ArticleImageView.contentMode = .scaleAspectFill

        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 0  
        titleLabel.lineBreakMode = .byWordWrapping

        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.05
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.masksToBounds = false
    }

}
