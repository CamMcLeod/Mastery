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
            taskIcon.layer.cornerRadius = 15.0
            taskIcon.layer.borderWidth = isSelected ? 2 : 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        taskIcon.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.4352941176, blue: 0.3176470588, alpha: 1)
        isSelected = false
    }
    
    public func configure(with icon: UIImage) {
        taskIcon.iconSetup(icon: icon, iconColor: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1))
    }
    
}
