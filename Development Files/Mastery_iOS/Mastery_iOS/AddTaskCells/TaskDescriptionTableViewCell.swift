//
//  TaskDescriptionTableViewCell.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-29.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class TaskDescriptionTableViewCell: UITableViewCell, UITextViewDelegate {

    
    @IBOutlet weak var taskDescription: UITextView!
    
    var delegate: GoalDescriptionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        taskDescription.delegate = self
        taskDescription.frame.size.height = 60
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let taskName = taskDescription.text,
            let rangeOfTextToReplace = Range(range, in: taskName) else {
                return false
        }
        let substringToReplace = taskName[rangeOfTextToReplace]
        let count = taskName.count - substringToReplace.count + text.count
        return count <= 200
    }
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        self.delegate?.getValueForDescription(theDescription: taskDescription.text)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
