//
//  TaskNameTableViewCell.swift
//  Mastery_iOS
//
//  Created by Marina Mona June McPeak on 2019-07-31.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class TaskNameTableViewCell : UITableViewCell, UITextFieldDelegate {
    
    var delegate: GoalNameCellDelegate?
    
    @IBOutlet weak var taskName: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        taskName.delegate = self
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let name = taskName.text,
            let rangeOfTextToReplace = Range(range, in: name) else {
                return false
        }
        let substringToReplace = name[rangeOfTextToReplace]
        let count = name.count - substringToReplace.count + string.count
        return count <= 30
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.delegate?.getValueForName(theName: taskName.text!)
        return true
    }
}
