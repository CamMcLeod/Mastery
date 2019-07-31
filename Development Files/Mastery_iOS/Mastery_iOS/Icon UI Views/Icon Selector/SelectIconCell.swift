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
    var goalColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    
    override var isSelected: Bool {
        didSet {
            taskIcon.layer.cornerRadius = 15.0
            taskIcon.layer.borderWidth = isSelected ? 2 : 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        taskIcon.layer.borderColor = goalColor.cgColor
        isSelected = false
    }
    
    public func configure(with icon: UIImage, color: UIColor) {
        taskIcon.iconSetup(icon: icon, iconColor: color)
        goalColor = color
    }
    
}
