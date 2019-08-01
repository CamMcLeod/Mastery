//
//  GoalNameTableViewCell.swift
//  Mastery_iOS
//
//  Created by Marina Mona June McPeak on 2019-07-31.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

protocol GoalNameCellDelegate {
    func getValueForName(theName: String)
}

class GoalNameTableViewCell: UITableViewCell, UITextFieldDelegate {

   
    
    @IBOutlet weak var goalName: UITextField!
    
     var delegate: GoalNameCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        goalName.delegate = self
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let goalName = goalName.text,
            let rangeOfTextToReplace = Range(range, in: goalName) else {
                return false
        }
        let substringToReplace = goalName[rangeOfTextToReplace]
        let count = goalName.count - substringToReplace.count + string.count
        return count <= 30
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }


    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.delegate?.getValueForName(theName: goalName.text!)
        return true
    }
    
    
    
}
