//
//  GoalDetailDescriptionTableViewCell.swift
//  Mastery_iOS
//
//  Created by Marina Mona June McPeak on 2019-07-31.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

protocol GoalDetailDescriptionCellDelegate {
    func getValueForDescription(description: String)
}

class GoalDetailDescriptionTableViewCell: UITableViewCell {
    
    var delegate: GoalDetailDescriptionCellDelegate?
    
    @IBOutlet weak var goalDescription: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.delegate?.getValueForDescription(description: goalDescription.text)
        
        
    }
    
}
