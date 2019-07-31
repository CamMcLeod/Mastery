//
//  GoalDetailDeadlineTableViewCell.swift
//  Mastery_iOS
//
//  Created by Marina Mona June McPeak on 2019-07-31.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

protocol GoalDetailDeadlineCellDelegate {
    func getValueForDeadline(date: Date)
}

class GoalDetailDeadlineTableViewCell: UITableViewCell {
    
    var delegate: GoalDetailDeadlineCellDelegate?
    
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var goalDeadlineDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
