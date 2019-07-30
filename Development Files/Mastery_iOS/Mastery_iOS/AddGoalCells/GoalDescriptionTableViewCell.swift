//
//  GoalDescriptionTableViewCell.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-28.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

protocol GoalDescriptionCellDelegate {
    func getValueForDescription(theDescription: String)
}

class GoalDescriptionTableViewCell: UITableViewCell, UITextViewDelegate {
    
    
    var delegate: GoalDescriptionCellDelegate?
    
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var goalDescription: UITextView!

    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        goalDescription.delegate = self
        goalDescription.frame.size.height = 60
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let goalName = goalDescription.text,
            let rangeOfTextToReplace = Range(range, in: goalName) else {
                return false
        }
        let substringToReplace = goalName[rangeOfTextToReplace]
        let count = goalName.count - substringToReplace.count + text.count
        return count <= 200
    }
    

    
    func textViewDidChange(_ textView: UITextView) {
        self.delegate?.getValueForDescription(theDescription: goalDescription.text)

        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
    }
    

}
