//
//  taskIconView.swift
//  Mastery_iOS
//
//  Created by Marina Mona June McPeak on 2019-07-27.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

@IBDesignable class TaskIcon : UIView{
    
    let kCONTENT_XIB_NAME = "TaskIcon"
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var taskRing: UIImageView!
    @IBOutlet weak var iconImage: UIImageView!
    
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
    
    func iconSetup(icon : UIImage?, iconColor : UIColor) {
        
        let tintedRing = taskRing.image?.withRenderingMode(.alwaysTemplate)
        taskRing.image = tintedRing
        taskRing.tintColor = iconColor
        
        let tintedImage = icon?.withRenderingMode(.alwaysTemplate)
        iconImage.image = tintedImage
        iconImage.tintColor = iconColor
    }
}
