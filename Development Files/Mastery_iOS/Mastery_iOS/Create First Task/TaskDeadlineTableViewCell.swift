//
//  TaskDeadlineTableViewCell.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-29.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class TaskDeadlineTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    var delegate: DatePickerTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         datePicker.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.delegate?.showStatusPickerCell(datePicker: datePicker)
        // Configure the view for the selected state
    }

    @IBAction func selectDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, YYYY"
        dateLabel.text = dateFormatter.string(from: sender.date)
        self.delegate?.dateChanged(toDate: sender.date)
    }
}
