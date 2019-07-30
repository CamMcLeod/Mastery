//
//  TaskPriorityTableViewCell.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-29.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class TaskPriorityTableViewCell: UITableViewCell {
    
    var delegate: GoalPriorityTableCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func selectPriority(_ sender: UISegmentedControl) {
        self.delegate?.getPriority(priority: Int16(sender.selectedSegmentIndex + 1))
    }
    
}
