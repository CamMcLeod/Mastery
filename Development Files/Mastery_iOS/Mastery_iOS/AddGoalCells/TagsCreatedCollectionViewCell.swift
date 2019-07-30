//
//  TagsCreatedCollectionViewCell.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-28.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class TagsCreatedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tagName.layer.borderColor = UIColor.darkGray.cgColor;
        tagName.layer.borderWidth = 1.0;
        
    }
    
}
