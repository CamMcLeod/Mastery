//
//  SelectIconCell.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-07-29.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class SelectIconCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            iconImage.layer.cornerRadius = 15.0
            iconImage.layer.borderWidth = isSelected ? 5 : 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImage.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.4352941176, blue: 0.3176470588, alpha: 1)
        isSelected = false
    }
    
    public func configure(with icon: UIImage) {
        iconImage.image = icon
    }
    
}
