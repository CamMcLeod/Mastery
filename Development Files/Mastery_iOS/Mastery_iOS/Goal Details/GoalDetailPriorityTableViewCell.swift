//
//  GoalDetailPriorityTableViewCell.swift
//  Mastery_iOS
//
//  Created by Marina Mona June McPeak on 2019-07-31.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

protocol GoalDetailPriorityCellDelegate {
    func getPriority(priority: Int16)
}

class GoalDetailPriorityTableViewCell: UITableViewCell {
    
    var delegate: GoalDetailPriorityCellDelegate?
    
    @IBOutlet weak var priorityTitle: UILabel!
    @IBOutlet weak var goalPriority: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
