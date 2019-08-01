//
//  GoalHoursTableViewCell.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-28.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

protocol GoalHoursTableCellDelegate {
    func getHours(hours: Float)
}

class GoalHoursTableViewCell: UITableViewCell {

    @IBOutlet weak var totalHoursTitle: UILabel!
    @IBOutlet weak var totalHoursLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var delegate: GoalHoursTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func getHours(_ sender: UISlider) {
        slider.value = Float(Int(slider.value / 50) * 50)
        let value = sender.value
        totalHoursLabel.text = String(format: "%.f", arguments: [value])
        self.delegate?.getHours(hours: sender.value)
    }
    
}
