//
//  TaskIconTableViewCell.swift
//  Mastery_iOS
//
//  Created by Marina Mona June McPeak on 2019-07-31.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

protocol TaskIconCellDelegate {
    func getIcon(icon: TaskIcon)
}

class TaskIconTableViewCell : UITableViewCell, IconSaveDelegate {

    
    
    @IBOutlet weak var taskIcon: TaskIcon!
    
    var delegate: TaskIconCellDelegate?
    var goalColor: UIColor?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func setNewImage(image: UIImage) {
        if let color = goalColor {
            taskIcon.iconSetup(icon: image, iconColor: color)
        }
         self.delegate?.getIcon(icon: taskIcon)
    }
    
}
