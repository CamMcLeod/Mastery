//
//  GoalDetailHoursTableViewCell.swift
//  Mastery_iOS
//
//  Created by Marina Mona June McPeak on 2019-07-31.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

protocol GoalDetailHoursCellDelegate {
    func getHours(hours: Float)
}

class GoalDetailHoursTableViewCell: UITableViewCell {
    
    var delegate: GoalDetailHoursCellDelegate?

    @IBOutlet weak var hoursTitle: UILabel!
    @IBOutlet weak var goalHours: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
