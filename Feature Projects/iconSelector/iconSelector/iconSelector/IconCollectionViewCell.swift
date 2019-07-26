//
//  IconCollectionViewCell.swift
//  iconSelector
//
//  Created by Cameron Mcleod on 2019-07-23.
//  Copyright © 2019 Cameron Mcleod. All rights reserved.
//

import UIKit

class IconCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            iconImage.layer.borderWidth = isSelected ? 5 : 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImage.layer.borderColor = UIColor.white.cgColor
        isSelected = false
    }
    
    public func configure(with model: IconModel) {
        iconImage.image = model.image
    }
}
    
