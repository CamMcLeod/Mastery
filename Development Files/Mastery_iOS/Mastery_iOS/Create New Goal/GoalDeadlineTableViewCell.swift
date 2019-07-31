//
//  GoalDeadlineTableViewCell.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-28.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

protocol DatePickerTableViewCellDelegate {
    func dateChanged(toDate date: Date)
    func showStatusPickerCell(datePicker: UIDatePicker)
}

class GoalDeadlineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var goalDeadlineTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: DatePickerTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        datePicker.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.delegate?.showStatusPickerCell(datePicker: datePicker)
    }

    @IBAction func selectDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, YYYY"
        dateLabel.text = dateFormatter.string(from: sender.date)
        self.delegate?.dateChanged(toDate: sender.date)
    }
}
