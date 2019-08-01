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

class TaskIconTableViewCell : UITableViewCell {
    
    @IBOutlet weak var taskIcon: TaskIcon!
    
     var delegate: TaskIconCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func taskIconDidChange(_ UIView: UIView) {
        self.delegate?.getIcon(icon: taskIcon)
        
    }
    
}
