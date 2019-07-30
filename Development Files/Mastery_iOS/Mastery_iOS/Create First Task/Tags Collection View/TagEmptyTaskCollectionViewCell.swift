//
//  EmptyTagCollectionViewCell.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-29.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class TagEmptyTaskCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var createNewTag: UITextField!
    var delegate: EmptyTagCollectionViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        createNewTag.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        self.delegate?.addTagToList(tagName: text)
        textField.resignFirstResponder()
        textField.text = ""
        return true
    }
    
    
    
    
  
}
