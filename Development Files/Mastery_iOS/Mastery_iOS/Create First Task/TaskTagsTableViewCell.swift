//
//  TaskTagsTableViewCell.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-29.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class TaskTagsTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tagsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
