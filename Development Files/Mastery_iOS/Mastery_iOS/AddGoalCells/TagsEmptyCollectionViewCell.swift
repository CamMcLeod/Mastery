//
//  TagsEmptyCollectionViewCell.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-28.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

protocol TagsEmptyCollectionCellDelegate {
    func addTagToList(tagName: String)
}

class TagsEmptyCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var createNewTag: UITextField!
    var delegate: TagsEmptyCollectionCellDelegate?
    
    
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
    
//    func textFieldShouldClear(_ textField: UITextField) -> Bool {
//        return true
//    }
    

}
