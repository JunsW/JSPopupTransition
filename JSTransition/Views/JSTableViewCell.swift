//
//  JSTableViewCell.swift
//  JSPopupTransition
//
//  Created by 王俊硕 on 2017/11/13.
//  Copyright © 2017年 王俊硕. All rights reserved.
//

import UIKit

class JSTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(title: String, imageName image: String, description: String) {
        titleLabel.text = title
        coverImageView.image = UIImage(named: image)
        descriptionLabel.text = description
        [titleLabel, descriptionLabel].forEach() {
            $0?.backgroundColor = .white
        }
    }
    
    
}
