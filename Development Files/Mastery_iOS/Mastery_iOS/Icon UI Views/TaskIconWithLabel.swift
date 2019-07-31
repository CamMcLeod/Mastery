//
//  taskIconWithLabelView.swift
//  Mastery_iOS
//
//  Created by Marina Mona June McPeak on 2019-07-27.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class TaskIconWithLabel : UIView {
    
    let kCONTENT_XIB_NAME = "TaskIcon"
    
    @IBOutlet weak var taskIcon: TaskIcon!
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    func setupWithIcon(name: String, newIcon: TaskIcon) {
        taskName.text = name
        taskIcon = newIcon
    }
    
    func setupWithRaw(name: String, newImage: UIImage, goalColor: UIColor) {
        taskName.text = name
        taskIcon.iconSetup(icon: newImage, iconColor: goalColor)
    }

}
