//
//  GoalDetailTableViewCell.swift
//  Mastery_iOS
//
//  Created by Marina Mona June McPeak on 2019-07-31.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

protocol GoalDetailNameCellDelegate {
    func getValueForName(name: String)
}

class GoalDetailNameTableViewCell: UITableViewCell {

    @IBOutlet weak var goalName: UILabel!
    
    var delegate: GoalDetailNameCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func labelDidChange(_ label: UILabel) {
        self.delegate?.getValueForName(name: goalName.text!)
        
        
    }
    
}
