//
//  StartEndCell.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-07-30.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class StartEndCell: UITableViewCell {
    
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public func configure(startDate: Date, endDate: Date color: goalColor) {
        startLabel.text = formatDate(date: startDate)
        endLabel.text = formatDate(date: endDate)
        
    }
    
    private func formatDate(date: Date) -> String {
        
        let RFC3339DateFormatter = DateFormatter()
        let dateMatch : String
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if Calendar.current.isDate(date, inSameDayAs:Date()) {
            
            
            RFC3339DateFormatter.dateFormat = "HH:mm"
            //        RFC3339DateFormatter.dateFormat = "MMM-dd"
            RFC3339DateFormatter.timeZone = TimeZone.current
            dateMatch = RFC3339DateFormatter.string(from: date)
            
        } else {
            
            RFC3339DateFormatter.dateFormat = "MMM d, HH:mm"
            //        RFC3339DateFormatter.dateFormat = "MMM-dd"
            RFC3339DateFormatter.timeZone = TimeZone.current
            dateMatch = RFC3339DateFormatter.string(from: date)
        }
        
        return dateMatch
        
    }
    
    
}
