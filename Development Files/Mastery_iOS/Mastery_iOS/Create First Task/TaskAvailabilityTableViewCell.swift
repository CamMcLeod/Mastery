//
//  TaskAvailabilityTableViewCell.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-29.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

protocol TaskAvailabilityCellDelegate {
    func selectedDates(daysOfWeek: [Bool])
}

class TaskAvailabilityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var availabilityLabel: UILabel!

    var dayAvailability: [Bool] = [false, false, false, false, false, false, false]
    @IBOutlet var daysAvailable: [UIButton]!
    var delegate: TaskAvailabilityCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        for button in daysAvailable {
//            button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
//        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    @IBAction func selectDates(_ sender: UIButton) {
        guard let day = daysAvailable.firstIndex(of: sender) else {return}
        dayAvailability[day] = !dayAvailability[day]
        self.delegate?.selectedDates(daysOfWeek: dayAvailability)
    }
}
