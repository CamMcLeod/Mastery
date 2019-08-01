//
//  SelectIconCell.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-07-29.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class SelectIconCell: UICollectionViewCell {
    
    
    @IBOutlet weak var taskIcon: TaskIcon!
    
    override var isSelected: Bool {
        didSet {
            self.layer.cornerRadius = 15.0
            self.layer.borderWidth = isSelected ? 3 : 0
            print(self.layer.borderColor)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isSelected = false
    }
    
    public func configure(with icon: UIImage, color: UIColor) {
        taskIcon.iconSetup(icon: icon, iconColor: color)
    }
    
}
