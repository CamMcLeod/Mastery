//
//  PreviousTaskCell.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-07-29.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class PreviousSessionCell: UITableViewCell {
    
    
    @IBOutlet weak var sessionDateLabel: UILabel!
    @IBOutlet weak var sessionDurationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with date: Date, duration: Int) {
        
        self.sessionDateLabel.text = formatSessionDate(date: date)
        self.sessionDurationLabel.text = duration.secondsToHoursMinutesSeconds()
    }
    
    private func formatSessionDate(date: Date) -> String {
        
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "MMM d, h:mm a"
//        RFC3339DateFormatter.dateFormat = "MMM-dd"
        RFC3339DateFormatter.timeZone = TimeZone.current
        let dateMatch = RFC3339DateFormatter.string(from: date)
       
        return dateMatch
        
    }
    

}
